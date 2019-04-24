//
//  UMTool.swift
//  MyGame
//
//  Created by MLive on 2019/4/18.
//  Copyright © 2019 Game. All rights reserved.
//

import UIKit

/// ACCESS ID
let XGPushAppId: UInt32 = 2200332249
/// ACCESS KEY
let XGPushAppKey:String = "IQ98G3GCZ83H"

class XGPushTool: NSObject {
    static let sharedManager = XGPushTool()

    override init() {
        super.init()
       
    }
    
    func startInitialize() {
        XGPush.defaultManager().startXG(withAppID: XGPushAppId, appKey: XGPushAppKey, delegate: self)
        XGPush.defaultManager().isEnableDebug = true
    }

}

extension XGPushTool: XGPushDelegate{
    // iOS 10 新增回调 API
    // App 用户点击通知
    // App 用户选择通知中的行为
    // App 用户在通知中心清除消息
    // 无论本地推送还是远程推送都会走这个回调
    func xgPush(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse?, withCompletionHandler completionHandler: @escaping () -> Void) {
        XGPush.defaultManager().reportXGNotificationResponse(response)
        completionHandler()
    }
    
    // App 在前台弹通知需要调用这个接口
    func xgPush(_ center: UNUserNotificationCenter, willPresent notification: UNNotification?, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        XGPush.defaultManager().reportXGNotificationInfo(notification?.request.content.userInfo ?? [:])
        completionHandler([UNNotificationPresentationOptions.badge,UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound])
    }
    
    func xgPushDidRegisteredDeviceToken(_ deviceToken: String?, error: Error?) {
        print("信鸽获取的设备token + \(String(describing: deviceToken))")
    }
    
    func xgPushDidFinishStart(_ isSuccess: Bool, error: Error?) {
        if isSuccess {
            print("信鸽启动成功")
        }else{
            print("信鸽error + \(String(describing: error))")
        }
    }
}

// MARK: - iOS 10.0 注册本地通知
extension XGPushTool{
    func cancelLocalNotiofication()  {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func registerLocalNotification() {
        cancelLocalNotiofication()
        
        let ary = ["你","我","xinlianxin"]
        let arc = arc4random() % UInt32(ary.count)
        let contentString: String = ary[Int(arc)]
        let timeTrigger = UNTimeIntervalNotificationTrigger.init(timeInterval:7 * 24 * 60 * 60, repeats: true)
        let content = UNMutableNotificationContent.init()
        content.body = contentString
//        content.badge = 1
        content.title = "爱你哟！小静子"
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "identifier", content: content, trigger: timeTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
        }
    }
}

extension XGPushTool: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
}



