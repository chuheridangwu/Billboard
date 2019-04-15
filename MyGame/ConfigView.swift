//
//  ConfigView.swift
//  MyGame
//
//  Created by dym on 2019/3/23.
//  Copyright © 2019年 Game. All rights reserved.
//

import UIKit

let count:CGFloat = 6
let margin: CGFloat = 15
let width = (screenWidth - (count + 1) * margin) / count

enum ViewType {
    case color
    case fontSize
    case seep
    case style
    enum FontStyle: String {
        case style1 = "Helvetica-Bold"
        case style2 = "FZXS12"
        case style3 = "STHeitiTC-Medium"
        case style4 = "PangMenZhengDao-Cu"
    }
}

class ConfigView: UIView {

    let backView = UIView.init(frame: CGRect.zero)
    let contentView = UIView.init(frame: CGRect.zero)
    let label1 = UIView.creatLabel(text: "速度")
    let label2 = UIView.creatLabel(text: "字号")
    let label3 = UIView.creatLabel(text: "字体")
    let label4 = UIView.creatLabel(text: "颜色")

    let listAry1 = [0,0.5,1,2,3,5]
    let listAry2 = [84,108,132,156,180]
    let listAry3 = [ViewType.FontStyle.style1,ViewType.FontStyle.style4,ViewType.FontStyle.style2,ViewType.FontStyle.style3]
    let listAry4 = [UIColor.red,.yellow,.blue,.white,.orange]

    let view1 = BtnListView.init(frame: CGRect.zero)
    let view2 = BtnListView.init(frame: CGRect.zero)
    let view3 = BtnListView.init(frame: CGRect.zero)
    let view4 = BtnListView.init(frame: CGRect.zero)
    
    let cellView1 = CellView.init(frame: CGRect.zero)
    let cellView2 = CellView.init(frame: CGRect.zero)
    
    var viewCallBack: swiftBlock?
    
        
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight))
        backgroundColor = .clear
        backView.frame = self.bounds
        addSubview(backView)
        addSubview(contentView)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(dismissView))
        backView.addGestureRecognizer(tap)
        contentView.alpha = 0.8
        contentView.backgroundColor = .black
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        contentView.addSubview(label4)
        contentView.addSubview(view1)
        contentView.addSubview(view2)
        contentView.addSubview(view3)
        contentView.addSubview(view4)
        contentView.addSubview(cellView1)
        contentView.addSubview(cellView2)


        let labelHeight = 30
        let marginHeight = 5
        
        let contentH = CGFloat(labelHeight) * CGFloat(6) + CGFloat(width) * CGFloat(4) + CGFloat( marginHeight * 10) + CGFloat(tabbarHeight) + 25
            contentView.snp.makeConstraints { (make) in
                make.left.right.bottom.equalTo(0)
                make.height.equalTo(contentH)
        }
        
        
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(0)
            make.height.equalTo(labelHeight)
        }
        
        view1.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label1.snp.bottom).offset(marginHeight)
            make.height.equalTo(width)
        }
        view1.type = ViewType.seep
        view1.viewAry = listAry1 as NSArray
        view1.select = 2
        
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view1.snp.bottom).offset(marginHeight)
            make.height.equalTo(labelHeight)
        }
        
        view2.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label2.snp.bottom).offset(marginHeight)
            make.height.equalTo(width)
        }
        view2.type = ViewType.fontSize
        view2.viewAry = listAry2 as NSArray
        view2.select = 2
        
        label3.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view2.snp.bottom).offset(marginHeight)
            make.height.equalTo(labelHeight)
        }
        
        view3.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label3.snp.bottom).offset(marginHeight)
            make.height.equalTo(width)
        }
        view3.type = ViewType.style
        view3.viewAry = listAry3 as NSArray
        view3.select = 3
        
        label4.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view3.snp.bottom).offset(marginHeight)
            make.height.equalTo(labelHeight)
        }
        
        view4.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label4.snp.bottom).offset(marginHeight)
            make.height.equalTo(width)
        }
        view4.type = ViewType.color
        view4.viewAry = listAry4 as NSArray
        view4.select = 0
        
        cellView1.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(view4.snp.bottom).offset(marginHeight)
            make.height.equalTo(35)
        }
        cellView1.type = 1
        cellView2.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(cellView1.snp.bottom).offset(marginHeight)
            make.height.equalTo(35)
        }
        cellView2.type = 2

    }
    
    
    func showView(block: @escaping swiftBlock){
        viewCallBack = block
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 2.0, options: [], animations: {
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        }, completion: nil)
    }
    
    @objc func dismissView(){
        UIView.animate(withDuration: 0.45, animations: {
            self.frame = CGRect(x: 0, y: -screenHeight, width: screenWidth, height: screenHeight)
            if self.viewCallBack != nil{
                self.viewCallBack!()
            }
        }) { (isEnd) in
            self.removeFromSuperview()
        }
    }
    
    func dismiss(block: @escaping swiftBlock){
        viewCallBack = block
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BtnListView: UIView{
    
    var type: ViewType = ViewType.fontSize
    
    var btnsAry: NSMutableArray = []

    var viewAry: NSArray = []{
        didSet{
            let offsetX = (width + margin)
            for index in 0..<viewAry.count {
                let str = viewAry[index]
                let btn = UIButton.init(frame: CGRect(x: margin + offsetX * CGFloat(index), y: 0, width: width, height: width))
                switch type{
                case .color:
                    btn.backgroundColor = str as? UIColor
                    break
                case .fontSize:
                    let title = "\(str)"
                    btn.setTitle(title, for: UIControl.State.normal)
                    break
                case .style:
                    switch str as! ViewType.FontStyle{
                    case .style1:
                        btn.titleLabel?.font = UIFont.init(name: ViewType.FontStyle.style1.rawValue, size: 16)
                        break
                    case .style2:
                        btn.titleLabel?.font = UIFont.init(name: ViewType.FontStyle.style2.rawValue, size: 16)
                        break
                    case .style3:
                        btn.titleLabel?.font = UIFont.init(name: ViewType.FontStyle.style3.rawValue, size: 16)
                        break
                    case .style4:
                        btn.titleLabel?.font = UIFont.init(name: ViewType.FontStyle.style4.rawValue, size: 16)
                        break
                        
                    }
                    btn.setTitle("样式", for: UIControl.State.normal)
                    break
                case .seep:
                    let title = "\(str)" + "x"
                    btn.setTitle(title, for: UIControl.State.normal)
                    break
                }
                btn.setTitleColor(.white, for: UIControl.State.normal)
                btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
                btn.tag = index
                addSubview(btn)
                btnsAry.add(btn)
            }
        }
    }
    
    
    
    var select: Int = 0{
        didSet{
            for index in 0..<btnsAry.count{
                let btn = btnsAry[index] as! UIButton
                let radius =  btn.viewWidth() / 2
                if index == select{
                    btn.layer.cornerRadius = radius
                    btn.layer.borderColor = UIColor.white.cgColor
                    btn.layer.borderWidth = 2
                }else{
                    btn.layer.cornerRadius = 0
                    btn.layer.borderColor = UIColor.black.cgColor
                    btn.layer.borderWidth = 0
                }
            }
            if type == ViewType.color{
                Config.shareInstance.textColor = viewAry[select] as! UIColor
            }
            initValue()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func clickBtn(btn: UIButton) {
        select = btn.tag
    }
    
    func initValue() {
        let str = viewAry[select]
        switch type{
        case .color:
            Config.shareInstance.textColor = viewAry[select] as! UIColor
            break
        case .fontSize:
            Config.shareInstance.fontSize = viewAry[select] as! CGFloat
            break
        case .style:
            switch str as! ViewType.FontStyle{
            case .style1:
                Config.shareInstance.fontStyle = ViewType.FontStyle.style1.rawValue
                break
            case .style2:
                Config.shareInstance.fontStyle = ViewType.FontStyle.style2.rawValue
                break
            case .style3:
                Config.shareInstance.fontStyle = ViewType.FontStyle.style3.rawValue
                break
            case .style4:
                Config.shareInstance.fontStyle = ViewType.FontStyle.style4.rawValue
                break
            }
            break
        case .seep:
            Config.shareInstance.speed = viewAry[select] as! CGFloat
            break
        }
    }
    
}


class CellView: UIView {
    
    var type: Int = 1{
        didSet{
            if type == 2{
                titleLabel.text = "闪烁"
                switchBtn.setOn(Config.shareInstance.isFlicker, animated: true)
            }else{
                switchBtn.setOn(Config.shareInstance.isCycle, animated: true)
            }
        }
    }
    
    let titleLabel: UILabel = UILabel.creatLabel(text: "循环播放")
    let switchBtn: UISwitch = UISwitch.init(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        switchBtn.onTintColor = .red
        switchBtn.addTarget(self, action: #selector(trunOn), for: UIControl.Event.touchUpInside)
        addSubview(titleLabel)
        addSubview(switchBtn)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.bottom.top.equalTo(0)
            make.right.equalTo(switchBtn.snp.left).offset(-5)
        }
        
        switchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(titleLabel)
        }
    }
    
    @objc func trunOn(switchBtn:UISwitch) {
        if type == 1{
            Config.shareInstance.isCycle = switchBtn.isOn
            Config.shareInstance.saveValue(value: switchBtn.isOn, key: cycle)
        }else{
            Config.shareInstance.isFlicker = switchBtn.isOn
            Config.shareInstance.saveValue(value: switchBtn.isOn, key: flicker)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
