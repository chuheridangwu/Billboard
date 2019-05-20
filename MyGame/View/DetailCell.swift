//
//  DetailCell.swift
//  MyGame
//
//  Created by MLive on 2019/4/28.
//  Copyright © 2019 Game. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}

class DetailCell: BaseCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK:  - 字体类型cell
class FontTypeCell: BaseCell {
    lazy var label: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .black
        label.text = "text3".localized
        return label
    }()
    
    var fontType: String = ""{
        didSet{
           label.font = UIFont.init(name: fontType, size: 26)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:  - 字体大小cell
class FontSizeCell: BaseCell {
    lazy var label: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var fontSize: CGFloat = 0{
        didSet{
            label.text = "text4".localized + " - " + "\(fontSize)"
            label.font = UIFont.init(name: Config.makeConfig.fontStyle, size: 22)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 颜色cell
class ColorCell: BaseCell {
    
    lazy var label: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textAlignment = .center
        return label
    }()
    
    var bgColor: Int = 0{
        didSet{
            label.text = "text6".localized
            label.textColor = .white
            label.backgroundColor = fontColor
        }
    }
    
    
    var fontColor: UIColor = .black{
        didSet{
            label.text = "text5".localized
            label.textColor = fontColor
            label.backgroundColor = .white
            label.font = UIFont.init(name: Config.makeConfig.fontStyle, size: 22)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 开关cell
class SwitchCell: BaseCell {
    
    lazy var label: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    lazy var openSwitch: UISwitch = {
        let sw = UISwitch.init(frame: .zero)
        sw.addTarget(self, action: #selector(trunSwich), for: UIControl.Event.valueChanged)
        return sw
    }()
    
    var isTrun: Bool = false{
        didSet{
            openSwitch.isOn = isTrun
        }
    }
    
    var labelText: String? = ""{
        didSet{
            label.text = labelText
            label.sizeToFit()
            switch labelText {
            case "text20".localized:
                openSwitch.isOn = Config.makeConfig.isShadow
            case "text21".localized:
                openSwitch.isOn = Config.makeConfig.isItalic
            default:
                openSwitch.isOn = Config.makeConfig.isFluore
            }
        }
    }
    
    @objc private func trunSwich(sw: UISwitch){
        switch labelText {
        case "text20".localized:
            Config.makeConfig.saveValue(value: sw.isOn, key: shadow)
            Config.makeConfig.isShadow = sw.isOn
        case "text21".localized:
            Config.makeConfig.saveValue(value: sw.isOn, key: italic)
             Config.makeConfig.isItalic = sw.isOn
        default:
            Config.makeConfig.saveValue(value: sw.isOn, key: fluore)
             Config.makeConfig.isFluore = sw.isOn
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(openSwitch)
        openSwitch.snp.makeConstraints { (make) in
            make.centerY.equalTo(label.snp_centerY)
            make.height.equalTo(30)
            make.width.equalTo(40)
            make.right.equalTo(-15)
        }
        label.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


