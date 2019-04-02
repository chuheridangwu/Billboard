//
//  ConfigView.swift
//  MyGame
//
//  Created by dym on 2019/3/23.
//  Copyright © 2019年 Game. All rights reserved.
//

import UIKit

let identifier: String = "UITableViewCell"

class ConfigView: UIView {

    let backView = UIView.init(frame: UIScreen.main.bounds)
    let contentView = UIView.init(frame: UIScreen.main.bounds)
    let label1 = UIView.creatLabel(text: "速度")
    let label2 = UIView.creatLabel(text: "字号")
    let label3 = UIView.creatLabel(text: "字体")
    let label4 = UIView.creatLabel(text: "颜色")

    let listAry1 = ["0","0.5x","1x","1.5x"]
    let listAry2 = ["24","36","48","64","72"]
    let listAry3 = ["样式","样式","样式","样式"]
    let listAry4 = [UIColor.red,.yellow,.blue,.yellow]

    let view1 = BtnListView.init(frame: CGRect.zero)
    let view2 = BtnListView.init(frame: CGRect.zero)
    let view3 = BtnListView.init(frame: CGRect.zero)
    let view4 = BtnListView.init(frame: CGRect.zero)

        
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = .clear
        backView.alpha = 1
        addSubview(backView)
        addSubview(contentView)
        
        contentView.addSubview(label1)
        contentView.addSubview(label2)
        contentView.addSubview(label3)
        contentView.addSubview(label4)
        contentView.addSubview(view1)
        contentView.addSubview(view2)
        contentView.addSubview(view3)
        contentView.addSubview(view4)
        
        let count:CGFloat = 6
        let margin: CGFloat = 10
        let width = (screenWidth - (count * margin)) / count

        
        label1.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(0)
            make.height.equalTo(30)
        }
        
        view1.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label1.snp_bottomMargin)
            make.height.equalTo(width)
        }
        view1.viewAry = listAry1 as NSArray
        view1.select = 2
        
        label2.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view1.snp_bottomMargin).offset(0)
            make.height.equalTo(30)
        }
        
        view2.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label2.snp_bottomMargin).offset(0)
            make.height.equalTo(width)
        }
        view2.viewAry = listAry2 as NSArray
        view2.select = 2
        
        label3.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view2.snp_bottomMargin).offset(0)
            make.height.equalTo(30)
        }
        
        view3.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(label3.snp_bottomMargin).offset(0)
            make.height.equalTo(width)
        }
        view3.viewAry = listAry3 as NSArray
        view3.select = 2
        
        label4.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(view3.snp_bottomMargin).offset(0)
            make.height.equalTo(30)
        }
        

        
//        let offsetX = margin + (width + margin)
//
//        for i in 0..<listAry.count {
//            let str = listAry[i]
//            let btn = UIButton.init(frame: CGRect(x: offsetX * CGFloat(i), y: 20, width: width, height: width))
//            btn.setTitle(str, for: UIControl.State.normal)
//            btn.setTitleColor(.white, for: UIControl.State.normal)
//            btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
//            addSubview(btn)
//        }
//
//        for i in 0..<listAry1.count {
//            let str = listAry1[i]
//            let btn = UIButton.init(frame: CGRect(x: offsetX * CGFloat(i), y: 60, width: width, height: width))
//            btn.setTitle(str, for: UIControl.State.normal)
//            btn.setTitleColor(.white, for: UIControl.State.normal)
//            btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
//            addSubview(btn)
//        }
//
//        for i in 0..<listAry2.count {
//            let str = listAry2[i]
//            let btn = UIButton.init(frame: CGRect(x: offsetX * CGFloat(i), y: 80, width: width, height: width))
//            btn.setTitle(str, for: UIControl.State.normal)
//            btn.setTitleColor(.white, for: UIControl.State.normal)
//            btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
//            addSubview(btn)
//        }
//
//        for i in 0..<listAry3.count {
//            let color = listAry3[i]
//            let btn = UIButton.init(frame: CGRect(x: offsetX * CGFloat(i), y: 80, width: width, height: width))
//            btn.setTitleColor(color, for: UIControl.State.normal)
//            btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
//            addSubview(btn)
//        }
        

    }
    
    @objc  func clickBtn(btn: UIButton)  {
        print("--- \(btn) ---")
    }
    
    func showView(){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.75) {

        }
    }
    
    func dismissView(){
        UIView.animate(withDuration: 0.75, animations: {
//            self.tableView.frame = CGRect(origin: CGPoint(x: 0, y: self.bounds.size.height), size: self.bounds.size)
        }) { (isEnd) in
            self.removeFromSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.dismissView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class BtnListView: UIView{
    
    let count:CGFloat = 6
    let margin: CGFloat = 10
    
    var viewAry: NSArray = []{
        didSet{
            let width = (screenWidth - (count * margin)) / count
            let offsetX = margin + (width + margin)
            for index in 0..<viewAry.count {
                let str = viewAry[index]
                let btn = UIButton.init(frame: CGRect(x: offsetX * CGFloat(index), y: 0, width: width, height: width))
                btn.setTitle(str as? String, for: UIControl.State.normal)
                btn.setTitleColor(.white, for: UIControl.State.normal)
                btn.addTarget(self, action: #selector(clickBtn), for: UIControl.Event.touchUpInside)
btn.tag = index
                addSubview(btn)
                btnsAry.add(btn)
            }
        }
    }
    
    var btnsAry: NSMutableArray = []
    
    
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
    
    
}
