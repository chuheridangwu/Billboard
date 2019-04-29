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
        label.text = "字体样式"
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
            label.text = "字体大小" + " - " + "\(fontSize)"
            label.font = UIFont.init(name: Config.shareInstance.fontStyle, size: 22)
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
            label.text = "背景颜色"
            label.textColor = .white
            label.backgroundColor = fontColor
        }
    }
    
    
    var fontColor: UIColor = .black{
        didSet{
            label.text = "字体颜色"
            label.textColor = fontColor
            label.backgroundColor = .white
            label.font = UIFont.init(name: Config.shareInstance.fontStyle, size: 22)
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



