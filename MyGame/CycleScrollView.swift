//
//  CycleScrollView.swift
//  MyGame
//
//  Created by MLive on 2019/4/11.
//  Copyright © 2019 Game. All rights reserved.
//

import UIKit

class CycleScrollView: UIScrollView {
    var seep: CGFloat = 1.0
    var startX: CGFloat = 0.0
    var margin = 10.0
    
    var views: [UIView] = []{
        didSet{
            if views.count == 0 {
                return
            }
            if isCycle == false || Config.shareInstance.speed == 0 {
                let label = views.first as! UILabel
                label.numberOfLines = 0
                label.frame = self.bounds
                self.addSubview(label)
                if Config.shareInstance.isFlicker{
                    addOpacityAnimation(view: label)
                }else{
                    label.layer.removeAllAnimations()
                }
                return;
            }
            
            let data = NSKeyedArchiver.archivedData(withRootObject: views.first ?? UIView.init())
            let view1 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view2 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view3 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view4 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view5 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view6 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view7 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view8 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view9 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view10 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view11 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view12 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view13 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view14 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view15 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view16 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view17 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView
            let view18 = NSKeyedUnarchiver.unarchiveObject(with: data) as! UIView

            views.append(view1)
            views.append(view2)
            views.append(view3)
            views.append(view4)
            views.append(view5)
            views.append(view6)
            views.append(view7)
            views.append(view8)
            views.append(view9)
            views.append(view10)
            views.append(view11)
            views.append(view12)
            views.append(view13)
            views.append(view14)
            views.append(view15)
            views.append(view16)
            views.append(view17)
            views.append(view18)
            refreshUI()
        }
    }
    var isCycle = true
    
    private var timer: CADisplayLink!
    
    private var displayX: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        startX = frame.size.width
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moveOffsetx()  {
        if self.contentOffset.x > displayX {
            self.contentOffset = CGPoint(x: startX, y: 0)
        }
        self.contentOffset = CGPoint(x: self.contentOffset.x + 1.0 * seep, y: 0)
    }
    
    func refreshUI()  {
        var maxWidth = startX
        for index in 0..<views.count {
            let view = views[index]
            let v_height = view.bounds.size.height
            let v_width = view.bounds.size.width
            let v_y = (self.bounds.size.height - v_height) / 2.0

            view.frame = CGRect(x: maxWidth, y: v_y, width: v_width, height: v_height)
            self.addSubview(view)
            maxWidth += v_width + 5
            if v_width < self.bounds.size.width / 2{
                if views.count - 14 == index{
                    displayX = maxWidth
                }
            }else{
                if views.count - 2 == index{
                    displayX = maxWidth
                }
            }
            if Config.shareInstance.isFlicker {
                addOpacityAnimation(view: view)
            }
        }
        self.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    
    func fire() {
        if timer != nil{
            timer.invalidate()
        }
        if seep == 0.0 || isCycle == false {
            return;
        }
        timer = CADisplayLink.init(target: self, selector: #selector(moveOffsetx))
        timer.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    
    func stopCycle()  {
        self.subviews.forEach { (item) in
            item.layer.removeAllAnimations()
            item.removeFromSuperview()
        }
        if (timer != nil){
            timer.invalidate()
        }
    }
    
    let identfian = "labelAnimation"
    private func addOpacityAnimation(view: UIView){
        let animation = CABasicAnimation.init(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.4
        animation.duration = 0.1
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeIn)
        view.layer.add(animation, forKey: identfian)
    }
    
}
