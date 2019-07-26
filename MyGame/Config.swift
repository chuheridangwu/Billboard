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
let shadow = "isShadow"
let italic = "isItalic"
let fluore = "isFluore"

typealias swiftBlock = () ->Void
typealias defaultValueBlock = () ->Void
typealias splashBlock = (Int) ->Void

class Config {
    
    var label: UILabel!
    
    var speed: CGFloat = 2 {
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    var textColor: UIColor = .yellow{
        didSet{
            label.textColor = textColor
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    var fontSize: CGFloat =  220{
        didSet{
            label.font = UIFont.init(name: fontStyle, size: fontSize)
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var fontStyle: String = "STHeitiTC-Medium"{
        didSet{
            label.font = UIFont.init(name: fontStyle, size: fontSize)
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var callBack: swiftBlock?
    var valueBlock: defaultValueBlock?
    var splashBlock: splashBlock?
    
    /// 自动循环
    var isCycle: Bool = UserDefaults.standard.bool(forKey: cycle){
        didSet{
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    /// 闪烁
    var isFlicker: Bool = UserDefaults.standard.bool(forKey: flicker){
        didSet{
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    /// 背景颜色
    var bgColor: UIColor = .black{
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    /// 滚动方向
    var isDirection:Bool = true{
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    /// 阴影
    var isShadow: Bool = UserDefaults.standard.bool(forKey: shadow){
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    /// 斜体
    var isItalic: Bool = UserDefaults.standard.bool(forKey: italic){
        didSet{
            label.frame.size = CGSize(width: isItalic ? label.viewWidth() + 35 : label.viewWidth(), height: label.viewHeight())
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
    
    /// 荧光
    var isFluore: Bool = UserDefaults.standard.bool(forKey: fluore){
        didSet{
            if valueBlock != nil {
                valueBlock!()
            }
        }
    }
 
    /// 荧光
    var splash: Int = 0{
        didSet{
                if splashBlock.self != nil {
                    splashBlock!(splash)
                }
        }
    }
    
    static let makeConfig = Config()
    private init(){
        isCycle = true
    }
    
    func saveValue(value:Bool, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func startAnimation(block: @escaping swiftBlock, defaultBlock: @escaping defaultValueBlock, splash:  @escaping splashBlock)  {
        callBack = block
        valueBlock = defaultBlock
        splashBlock = splash
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
