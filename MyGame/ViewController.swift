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
    
    var time: Double = 10
    
    lazy var label :UILabel = {
        let label = UILabel.init(frame: CGRect(x: view.frame.size.height, y:0, width: view.frame.size.height, height: view.frame.size.width))
        label.font = UIFont.systemFont(ofSize: 100)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    lazy var label1 :UILabel = {
        let label = UILabel.init(frame: CGRect(x: view.frame.size.height, y:0, width: view.frame.size.height, height: view.frame.size.width))
        label.font = UIFont.systemFont(ofSize: 100)
        label.textColor = .white
        label.textAlignment = .left
        label.backgroundColor = .red
        label.numberOfLines = 1
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
        textView.text = "在这里输入要滚动的字幕"
        textView.textAlignment = .center
        textView.placeholder = "请在这里输入要滚动的字幕"
        return textView
    }()
    
    lazy var animation: CABasicAnimation = {
        let min = label.viewWidth() / screenWidth * 5;
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
            let str: String! = subtitle
            label.text = str
            let width = str.textWidth(font: label.font.pointSize, height: label.frame.size.height)
            time = Double(width / 10)
            label.frame = CGRect(x:view.frame.size.height, y: 0, width: width, height: view.frame.size.width)
            label1.frame = CGRect(x:view.frame.size.height + width, y: 0, width: width, height: view.frame.size.width)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(contentView)
        contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        contentView.addSubview(label)
        contentView.addSubview(label1)
        view.addSubview(textView)
        view.addSubview(btn)

        self.startAnimate()
        self.addNotification()
        
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
        self.startAnimate()
        view.endEditing(true)
    }

    func startAnimate(){
        subtitle = textView.text
        self.label.layer.removeAnimation(forKey: "test")
        self.label.layer.add(animation, forKey: "test")
    }
    
    @objc func showConfigView(){
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
        self.startAnimate()
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


