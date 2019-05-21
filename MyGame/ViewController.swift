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
        label.font = UIFont.init(name: Config.makeConfig.fontStyle, size: Config.makeConfig.fontSize)
        label.textColor = Config.makeConfig.textColor
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
        textView.placeholder = "text1".localized
        textView.text = "text1".localized
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
    
    lazy var cycleView: CycleScrollView = {
       let cycleView = CycleScrollView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.height, height: view.frame.size.width))
        return cycleView
    }()
    
    let setView = ListHeaderView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(contentView)
        contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        contentView.addSubview(cycleView)
        view.addSubview(bottomView)
        label.sizeToFit()
        self.addNotification()

        Config.makeConfig.label = label
        Config.makeConfig.startAnimation(block: {
            self.startAnimation()

        }) {
            self.settingLabelValue()
        }
        self.startAnimation()
        timer.fireDate = Date.init(timeIntervalSinceNow: animationTime)
        view.addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(switchPanView)))
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(touchTapView)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 保持常亮
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 保持常亮
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

  fileprivate  func startAnimation()  {
        self.label.numberOfLines = 1
        self.label.sizeToFit()
        self.cycleView.stopCycle()
        self.cycleView.isCycle = Config.makeConfig.isCycle
        self.cycleView.seep = Config.makeConfig.speed
        self.cycleView.views = [Config.makeConfig.label]
        self.cycleView.fire()
    }
    
    fileprivate func settingLabelValue(){
        self.view.backgroundColor = Config.makeConfig.bgColor
        self.cycleView.changeLableValue()
        if Config.makeConfig.isDirection {
            self.contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }else{
            self.contentView.transform = CGAffineTransform(rotationAngle: CGFloat.pi +  (CGFloat.pi / 2))
        }
    }
    
    @objc func showConfigView(){
        view.endEditing(true)
        isHiddenBottomView()
        setView.showView()
    }
    
    // MARK: - 是否隐藏底部视图
    private func isHiddenBottomView() {
        if bottomView.frame.origin.y < view.viewHeight() && bottomView.frame.origin.y >= self.view.viewHeight() - 64 - tabbarHeight  {
            timer.fireDate = Date.distantFuture
            UIView.animate(withDuration: 0.4) {
                self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() - 64 - tabbarHeight + 120, width: self.view.viewWidth(), height: 44)
            }
        }else{
            timer.fireDate = Date.init(timeIntervalSinceNow: animationTime)
            UIView.animate(withDuration: 0.4) {
                self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() - 64 - tabbarHeight , width: self.view.viewWidth(), height: 44)
            }
        }
    }
    
    // MARK: - 隐藏底部视图
    @objc func closeBottomView() {
        timer.fireDate = Date.distantFuture
        UIView.animate(withDuration: 0.4) {
            self.bottomView.frame = CGRect(x: 0, y: self.view.viewHeight() - 64 - tabbarHeight + 120, width: self.view.viewWidth(), height: 44)
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

// MARK: - 键盘
extension ViewController{
    
    fileprivate  func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillhidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
   
    @objc func keyBoardWillShow(_ notification:Notification) {
        if setView.isShow  { return }
        
        let info : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
        let time = info["UIKeyboardAnimationDurationUserInfoKey"]
        timer.fireDate = Date.distantFuture
        
        UIView.animate(withDuration: time as! TimeInterval) {
            self.bottomView.frame = CGRect(x: 0, y: keyboardSize.origin.y - 44 - 20, width: self.view.viewWidth(), height: 44)
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

// MARK: - 手势
extension ViewController{
    @objc private func switchPanView(pan: UIPanGestureRecognizer){
        if pan.state == .ended {
            self.commitTranslation(translation: pan.translation(in: self.view))
        }
    }
    
    private func commitTranslation(translation: CGPoint){
        let absX = abs(translation.x)
        let absY = abs(translation.y)
        guard max(absX,absY) > 10 else { // 设置滑动有效距离
            return;
        }
        if (absX > absY ) { //左右滑动
            
            if (translation.x<0) {
                //向左滑动
            }else{
                //向右滑动
                setView.showView()
                closeBottomView()
            }
            
        } else if (absY > absX) { // 上下滑动
            if (translation.y<0) {
                //向上滑动
            }else{
                //向下滑动
            }
        }
    }
    
    @objc private func touchTapView(){
        if textView.text != subtitle && textView.text?.count ?? 0 > 0{
            subtitle = textView.text?.count ?? 0 > 0 ? textView.text : textView.placeholder
            startAnimation()
        }
        isHiddenBottomView()
        view.endEditing(true)
    }
}

