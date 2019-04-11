//
//  StringExtension.swift
//  MyGame
//
//  Created by MLive on 2019/3/19.
//  Copyright © 2019 Game. All rights reserved.
//

// 计算字符串高度 https://www.jianshu.com/p/0dd6141c46db

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let statusHeight = UIApplication.shared.statusBarFrame.size.height //tabbar状态栏高度
let tabbarHeight = statusHeight >= 20 ? 34 : 0

extension String{
    
    func textHeight(font:CGFloat, width:CGFloat) -> CGFloat {
        let rect: CGRect = self.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: [NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: font)], context: nil)
        return rect.height
    }
    
    func textWidth(font:CGFloat, height:CGFloat) -> CGFloat {
        let rect: CGRect = self.boundingRect(with:CGSize(width: CGFloat(MAXFLOAT), height: height),options:[NSStringDrawingOptions.usesFontLeading,NSStringDrawingOptions.usesLineFragmentOrigin],attributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: font)],context:nil)
        return rect.width
    }
    
}


extension UIView{
    
    func viewHeight() ->CGFloat {
        return self.frame.size.height
    }
    
    func viewWidth() ->CGFloat {
        return self.frame.size.width
    }
    
    func viewX() ->CGFloat {
        return self.frame.origin.x
    }
    func viewY() ->CGFloat {
        return self.frame.origin.y
    }
    func setViewWidth(width:CGFloat){
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width:width , height: self.frame.size.height)
    }
}
