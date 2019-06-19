//
//  ADTool.swift
//  BannerExample
//
//  Created by MLive on 2019/4/16.
//  Copyright © 2019 Google. All rights reserved.
//

import UIKit
import GoogleMobileAds

let ScreenSize = UIScreen.main.bounds.size
let saveTime = "lastSaveTime" // 最后保存的时间

class AdmobTool: NSObject {
    
    static let sharedManager = AdmobTool()

    
   func startInitialize(){
         GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var interstitial: GADInterstitial!
    var bannerView: GADBannerView!
    
    override init() {
        super.init()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        createAndLoadInterstitial()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        loadVideoAd()
        if (UserDefaults.standard.object(forKey: saveTime) == nil){
           saveCurrentTime()
        }
    }
    
    func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-8177181808824082/8938224700")
        interstitial.delegate = self
        // FIXME: - 这里如果不进行延时，会造成崩溃，现象是在初始化的时候在viewDidLoad方法中加载bannerView 和 当前类初始化加载插页广告 猜测发生的原因是网络加载的时候，会对当前对象进行重新赋值，没有做验证
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.interstitial.load(GADRequest())
        }
    }
    
    func loadVideoAd()  {
        // FIXME: 理由同上
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
//            GADRewardBasedVideoAd.sharedInstance().load(GADRequest(),
//                                                        withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
        }
    }
    
    func showInterstitial(showController: UIViewController) {
        if isShowAdmob() == false {
            return
        }
        if interstitial.isReady {
            interstitial.present(fromRootViewController: showController)
        } else {
            print("Ad wasn't ready")
        }
    }
    
    func showBananerView(showController: UIViewController) {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = showController
        bannerView.frame = CGRect(origin: CGPoint(x: (ScreenSize.width - kGADAdSizeBanner.size.width) / 2.0, y: ScreenSize.height - kGADAdSizeBanner.size.height - tabbarHeight), size: kGADAdSizeBanner.size)
        showController.view.addSubview(bannerView)
        bannerView.load(GADRequest())
    }
    
    func showVideoADView(showController: UIViewController)  {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: UIApplication.shared.keyWindow?.rootViewController ?? showController)
        }else{
            print("video ad wasn't ready")
        }
    }
    
    // MARK: - 计算是否显示广告,暂定为3天显示一次广告
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter
    }()
    
    func isShowAdmob() -> Bool {
        let saveDate = dateFormatter.date(from: UserDefaults.standard.object(forKey: saveTime) as! String)
        let calendar = Calendar.current
        let dateComponets = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month,Calendar.Component.day,Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: saveDate ?? Date.init(), to: Date.init())
        if dateComponets.day ?? 4 > 3 {
            return true
        }
        return false
    }
    
    func saveCurrentTime() {
        let dateString = dateFormatter.string(from: Date.init())
        UserDefaults.standard.set(dateString, forKey: saveTime)
    }
}

extension AdmobTool: GADInterstitialDelegate{
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate the interstitial had been animated off the screen.
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        createAndLoadInterstitial()
        saveCurrentTime()
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
}

extension AdmobTool: GADRewardBasedVideoAdDelegate{
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
        loadVideoAd()
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load.")
    }
}
