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
typealias swiftBlock = () ->Void
class Config {
    
    var label: UILabel!
    
    var speed: CGFloat = 1{
        didSet{
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var textColor: UIColor = .white{
        didSet{
            label.textColor = textColor
            if callBack != nil {
                callBack!()
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
    
    var isCycle: Bool = UserDefaults.standard.bool(forKey: cycle){
        didSet{
            if callBack != nil {
                callBack!()
            }
        }
    }
    
    var isFlicker: Bool = UserDefaults.standard.bool(forKey: flicker)

 
    
    static let shareInstance = Config()
    private init(){}
    
    func saveValue(value:Bool, key: String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func startAnimation(block: @escaping swiftBlock)  {
        callBack = block
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
