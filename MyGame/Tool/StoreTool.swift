//
//  StoreTool.swift
//  MyGame
//
//  Created by MLive on 2019/4/23.
//  Copyright © 2019 Game. All rights reserved.
//

import UIKit
import StoreKit

enum InpurcaseError: Error {
    case noPermission //没有内购许可
    case noExist // 不存在商品
    case failTransactions // 交易失败
    case noReceipt // 交易成功未找到成功凭证
}

typealias Order = (productIdentifiers: String, userName: String)

class StoreTool: NSObject {
    static let makeInitialize = StoreTool()
    
    /// 掉单/未完成的订单回调 (凭证, 交易, 交易队列)
    var unFinishedTransaction: ((String, SKPaymentTransaction, SKPaymentQueue) ->())?
    
    private var sandBoxURLString = "https://sandbox.itunes.apple.com/verifyReceipt"
    private var buyURLString = "https://buy.itunes.apple.com/verifyReceipt"
    
    fileprivate var isComplete: Bool = true
    fileprivate var products:[SKProduct] = []
    fileprivate var failBock: ((InpurcaseError) -> ())?
    
    /// 交易完成的回调 (凭证, 交易, 交易队列)
    fileprivate var receiptBlock:((String, SKPaymentTransaction, SKPaymentQueue) -> ())?
    fileprivate var successBlock:(() -> Order)?
    
    override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }
    
    /// 开始向Apple Store请求产品列表数据，并购买指定的产品，得到Apple Store的Receipt，失败回调
    ///
    /// - Parameters:
    ///   - productIdentifiers: 请求指定产品
    ///   - successBlock: 请求产品成功回调，这个时候可以返回需要购买的产品ID和用户的唯一标识，默认为不购买
    ///   - receiptBlock: 得到Apple Store的Receipt和transactionIdentifier，这个时候可以将数据传回后台或者自己去post到Apple Store
    ///   - failBlock: 失败回调
    func start(productIdentifiers: Set<String>,
               successBlock:(() ->Order)? = nil,
               receiptBlock: ((String, SKPaymentTransaction, SKPaymentQueue) -> ())? = nil,
               failBlock: ((InpurcaseError) -> ())? = nil){
        guard isComplete else {return }
        defer { isComplete = false }
        
        for transaction in SKPaymentQueue.default().transactions { //在下次购买之前检测是否有未完成的交易如果有就关闭
            if transaction.transactionState == .purchased{
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
        let request = SKProductsRequest(productIdentifiers: productIdentifiers)
        request.delegate = self
        request.start()
        self.successBlock = successBlock
        self.receiptBlock = receiptBlock
        self.failBock = failBlock
    }

}

extension StoreTool: SKPaymentTransactionObserver, SKProductsRequestDelegate{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        guard let order = successBlock?() else {return}
        buy(order)
    }
    
    fileprivate func buy(_ order: Order){
        let buyProduct = products.first{$0.productIdentifier == order.productIdentifiers}
        guard let product = buyProduct else {failBock?(.noExist); return}
        guard SKPaymentQueue.canMakePayments() else {failBock?(.noPermission); return}
        
        let payment = SKMutablePayment(product: product)
        payment.applicationUsername = order.userName
        SKPaymentQueue.default().add(payment)
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState{
            case .purchased:
                // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
                guard let receipUrl = Bundle.main.appStoreReceiptURL, let receipData = NSData(contentsOf: receipUrl) else {failBock?(.noReceipt); return}
                let receiptString = receipData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                if let receiptBlock = receiptBlock{
                    receiptBlock(receiptString,transaction,queue)
                }else{
                    unFinishedTransaction?(receiptString, transaction, queue)
                }
                queue.finishTransaction(transaction)
                isComplete = true
            case .failed:
                failBock?(.failTransactions)
                queue.finishTransaction(transaction)
                isComplete = true
            case .restored:
                queue.finishTransaction(transaction)
                isComplete = true
            default:
                break
            }
        }
    }
}
