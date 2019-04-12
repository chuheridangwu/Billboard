//
//  ViewController.swift
//  MyGame
//
//  Created by MLive on 2019/3/19.
//  Copyright © 2019 Game. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    lazy var contentView :UIView = {
       let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.height, height: self.view.bounds.size.width))
        view.center = self.view.center
        return view;
    }()
    
    var time: TimeInterval = 5
    
    lazy var label :UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y:0, width: view.frame.size.height, height: view.frame.size.width))
        label.font = UIFont.init(name: "STHeitiTC-Medium", size: 120)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    
    lazy var textView: UITextField = {
        let textView = UITextField.init(frame: CGRect(x: 20, y: view.viewHeight() - 60 - statusHeight, width: view.viewWidth() - 60, height: 44))
        if #available(iOS 11, *){
            textView.frame =  CGRect(x: 20, y: view.viewHeight() - 60 - view.safeAreaInsets.bottom, width: view.viewWidth() - 60, height: 44)
        }
        textView.backgroundColor = .white
        textView.delegate = self
        textView.borderStyle = .roundedRect
        textView.textAlignment = .center
        textView.placeholder = "请在这里输入要滚动的字幕"
//        textView.placeholder = "1"

        subtitle = textView.placeholder
        return textView
    }()
    
    lazy var animation: CABasicAnimation = {
        let min = label.viewWidth() / screenHeight * Config.shareInstance.speed;
        let animation = CABasicAnimation.init(keyPath: "transform.translation.x")
        animation.toValue = -(label.frame.size.width + view.bounds.size.height)
        animation.duration = CFTimeInterval(min)
        animation.isRemovedOnCompletion = false
        animation.repeatCount = MAXFLOAT
        animation.delegate = self
        return animation
    }()
    
    var subtitle: String!{
        didSet{
            label.text = subtitle
            label.sizeToFit()
//            let str: String! = subtitle
//            label.text = str
//            let width = str.textWidth(font: label.font.pointSize, height: label.frame.size.height)
//            label.frame = CGRect(x:view.frame.size.height, y: 0, width: width, height: view.frame.size.width)

        }
    }
    
    lazy var btn: UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.addTarget(self, action: #selector(showConfigView), for: UIControl.Event.touchUpInside)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.backgroundColor = .yellow
        return btn
    }()

    lazy var configView: ConfigView = {
        let view = ConfigView.init(frame: self.view.bounds)
        return view
    }()
    
    lazy var cycleView: CycleScrollView = {
       let cycleView = CycleScrollView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.height, height: view.frame.size.width))
        return cycleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(contentView)
        contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        contentView.addSubview(cycleView)
        view.addSubview(textView)
        view.addSubview(btn)
        label.sizeToFit()
        self.addNotification()
        
        Config.shareInstance.label = label
        Config.shareInstance.startAnimation {
            self.label.numberOfLines = 1
            self.label.sizeToFit()
            self.cycleView.stopCycle()
            self.cycleView.isCycle = Config.shareInstance.isCycle
            self.cycleView.seep = Config.shareInstance.speed
            self.cycleView.views = [Config.shareInstance.label]
            self.cycleView.fire()
        }
        configView.dismiss {
            UIView.animate(withDuration: 0.45) {
                self.textView.frame = CGRect(x: 20, y: self.view.viewHeight() - 60, width: self.view.viewWidth() - 60 - statusHeight, height: 44)
            }
        }
        
        cycleView.views = [Config.shareInstance.label]
        cycleView.fire()
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillhidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        view.endEditing(true)
        
    }

    
    @objc func showConfigView(){
        UIView.animate(withDuration: 0.4) {
            self.textView.frame = CGRect(x: 20, y: self.view.viewHeight() - 60 - statusHeight  + 120, width: self.view.viewWidth() - 60, height: 44)
        }
        configView.showView()
    }
    
    @objc func keyBoardWillShow(_ notification:Notification) {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = info["UIKeyboardFrameBeginUserInfoKey"] as! CGRect
        let time = info["UIKeyboardAnimationDurationUserInfoKey"]
        
        UIView.animate(withDuration: time as! TimeInterval) {
            self.textView.frame = CGRect(x: 20, y: self.view.viewHeight() - keyboardSize.size.height - 44 -  statusHeight - 20, width: self.view.viewWidth() - 60, height: 44)
        }
    }
    
    @objc func keyBoardWillhidden(_ notification: Notification)  {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let time = info["UIKeyboardAnimationDurationUserInfoKey"]
        
        UIView.animate(withDuration: time as! TimeInterval) {
            self.textView.frame = CGRect(x: 20, y: self.view.viewHeight() - 60, width: self.view.viewWidth() - 60 - statusHeight, height: 44)
        }
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

extension ViewController: CAAnimationDelegate{
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
}


