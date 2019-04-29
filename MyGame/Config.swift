//
//  Config.swift
//  MyGame
//
//  Created by dym on 2019/3/23.
//  Copyright © 2019年 Game. All rights reserved.
//

import UIKit


let cycle = "isCycle"
let flicker = "isFlicker"
let direction = "isRight"

typealias swiftBlock = () ->Void
typealias defaultValueBlock = () ->Void

class Config {
    
    var label: UILabel!
    
    var speed: CGFloat = 1{
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    var textColor: UIColor = .white{
        didSet{
            label.textColor = textColor
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    var fontSize: CGFloat =  16{
        didSet{
            label.font = UIFont.init(name: fontStyle, size: fontSize)
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var fontStyle: String = ""{
        didSet{
            label.font = UIFont.init(name: fontStyle, size: fontSize)
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var callBack: swiftBlock?
    var valueBlock: defaultValueBlock?
    
    var isCycle: Bool = UserDefaults.standard.bool(forKey: cycle){
        didSet{
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var isFlicker: Bool = UserDefaults.standard.bool(forKey: flicker){
        didSet{
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var bgColor: UIColor = .black{
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    var isDirection:Bool = true{
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
 
    
    static let shareInstance = Config()
    private init(){}
    
    func saveValue(value:Bool, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func startAnimation(block: @escaping swiftBlock, defaultBlock: @escaping defaultValueBlock)  {
        callBack = block
        valueBlock = defaultBlock
    }
    
}

extension UIView{
    class func creatLabel(text:NSString = "",fontSize: CGFloat = 16) -> UILabel {
        let label = UILabel.init(frame: CGRect.zero)
        label.text = text as String
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }
}
