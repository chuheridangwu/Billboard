//
//  ViewController.swift
//  MyGame
//
//  Created by MLive on 2019/3/19.
//  Copyright © 2019 Game. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let animationTime: TimeInterval = 8
    
    lazy var contentView :UIView = {
       let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.height, height: self.view.bounds.size.width))
        view.center = self.view.center
        return view;
    }()
    
    lazy var label :UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y:0, width: view.frame.size.height, height: view.frame.size.width))
        label.font = UIFont.init(name: "STHeitiTC-Medium", size: 120)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view1 = UIView.init(frame: CGRect(x: 0, y: view.viewHeight() - 64.0 - tabbarHeight, width: view.viewWidth(), height: 44))
        view1.addSubview(textView)
        view1.addSubview(setBtn)
        return view1
    }()
    
    lazy var textView: UITextField = {
        let textView = UITextField.init(frame: CGRect(x: 20, y: 0, width: view.viewWidth() - 80, height: 44))
        textView.backgroundColor = .white
        textView.delegate = self
        textView.borderStyle = .roundedRect
        textView.textAlignment = .center
        textView.placeholder = "请在这里输入要滚动的字"
        textView.layer.cornerRadius = 22
        textView.layer.masksToBounds = true
        subtitle = textView.placeholder
        return textView
    }()
    
    lazy var setBtn: UIButton = {
        let btn = UIButton.init(frame: CGRect(x: view.viewWidth() - 55, y: 4.5, width: 35, height: 35))
        btn.addTarget(self, action: #selector(showConfigView), for: UIControl.Event.touchUpInside)
        btn.setBackgroundImage(UIImage.init(named: "setting.png"), for: UIControl.State.normal)
        return btn
    }()
    
    lazy var timer: Timer = {
        let timer = Timer.init(timeInterval: animationTime, target: self, selector: #selector(closeBottomView), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        return timer
    }()
    
    var subtitle: String!{
        didSet{
            label.text = subtitle
        }
    }

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
        view.addSubview(bottomView)
        label.sizeToFit()
        self.addNotification()

        Config.shareInstance.label = label
        Config.shareInstance.startAnimation {
            self.startAnimation()
        }
        configView.dismiss {
            self.isHiddenBottomView()
        }
        
        cycleView.views = [Config.shareInstance.label]
        cycleView.fire()
        timer.fireDate = Date.init(timeIntervalSinceNow: animationTime)
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
        isHiddenBottomView()
        view.endEditing(true)
    }

    func startAnimation()  {
        self.label.numberOfLines = 1
        self.label.sizeToFit()
        self.cycleView.stopCycle()
        self.cycleView.isCycle = Config.shareInstance.isCycle
        self.cycleView.seep = Config.shareInstance.speed
        self.cycleView.views = [Config.shareInstance.label]
        self.cycleView.fire()
    }
    
    @objc func showConfigView(){
        isHiddenBottomView()
        configView.showView(showController: self) {
            self.isHiddenBottomView()
        }
        AdmobTool.sharedManager.showInterstitial(showController: self)
    }
    
    // MARK: - 是否隐藏底部视图
    private func isHiddenBottomView() {
        if bottomView.frame.origin.y > view.viewHeight() {
            timer.fireDate = Date.init(timeIntervalSinceNow: animationTime)
            UIView.animate(withDuration: 0.35) {
                self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() - 64 - tabbarHeight, width: self.view.viewWidth(), height: 44)
            }
        }else{
            closeBottomView()
        }
    }
    
    // MARK: - 隐藏底部视图
    @objc func closeBottomView() {
        timer.fireDate = Date.distantFuture
        if bottomView.frame.origin.y < view.viewHeight() && bottomView.frame.origin.y >= self.view.viewHeight() - 64 - tabbarHeight  {
            UIView.animate(withDuration: 0.4) {
                self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() - 64 - tabbarHeight + 120, width: self.view.viewWidth(), height: 44)
            }
        }else{
            UIView.animate(withDuration: 0.4) {
                self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() - 64 - tabbarHeight , width: self.view.viewWidth(), height: 44)
            }
        }
    }
    
    // MARK: - 键盘通知
    @objc func keyBoardWillShow(_ notification:Notification) {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = info["UIKeyboardFrameBeginUserInfoKey"] as! CGRect
        let time = info["UIKeyboardAnimationDurationUserInfoKey"]
        timer.fireDate = Date.distantFuture
        
        UIView.animate(withDuration: time as! TimeInterval) {
            self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() - keyboardSize.size.height - 64 -  tabbarHeight, width: self.view.viewWidth(), height: 44)
        }
    }
    
    @objc func keyBoardWillhidden(_ notification: Notification)  {
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let time = info["UIKeyboardAnimationDurationUserInfoKey"]
        timer.fireDate = Date.init(timeIntervalSinceNow: animationTime)
        UIView.animate(withDuration: time as! TimeInterval) {
            self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() -  64 -  tabbarHeight , width: self.view.viewWidth(), height: 44)
        }
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        subtitle = textField.text?.count ?? 0 > 0 ? textField.text : textField.placeholder
        startAnimation()
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


