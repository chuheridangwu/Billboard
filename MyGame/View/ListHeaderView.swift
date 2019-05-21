//
//  ListHeaderView.swift
//  MyGame
//
//  Created by MLive on 2019/4/24.
//  Copyright © 2019 Game. All rights reserved.
//

import UIKit

enum ItmeType {
    case seep([CGFloat],String)   ///
    case font([String],String)    ///
    case fontSize([CGFloat],String)     ///
    case fontColor([UIColor],String) ///
    case bgColor([UIColor],String) ///
    case direction([String],String)
    case isRepeat([String],String)
    case filker([String],String)
    case attribute([String],String)
    case anthor([String],String)
}

class ListHeaderView: UIView {
    
    var isShow:Bool = false
    
   fileprivate let itemView = ListItemView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    fileprivate let listAry: [ItmeType] = [ItmeType.seep([0.5,1,2,3,5],"text2".localized),
                                           ItmeType.font(["Helvetica-Bold","STHeitiTC-Medium","PangMenZhengDao-Cu","HYXingYuTiJ","ZoomlaWuanYue-A017"],"text3".localized),
                                           ItmeType.fontSize([80,120,180,220,280,320],"text4".localized),
                                           ItmeType.fontColor([UIColor.red,.blue,.yellow,.white,.black,.green,.darkGray],"text5".localized),
                                           ItmeType.bgColor([UIColor.red,.blue,.yellow,.white,.black,.green,.darkGray],"text6".localized),
                                           ItmeType.attribute(["text20".localized,"text21".localized,"text22".localized],"text19".localized),
                                           ItmeType.direction(["text11".localized,"text12".localized],"text7".localized),
                                           ItmeType.filker(["text13".localized,"text14".localized],"text8".localized),
                                           ItmeType.isRepeat(["text15".localized,"text16".localized],"text9".localized),
                                           ItmeType.anthor(["text17".localized,"text18".localized],"text10".localized)]
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: -100, y: 0, width: 120, height: listAry.count * 44), style: UITableView.Style.plain)
        tableView.delegate  = self
        tableView.dataSource  = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "index")
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.backgroundColor = .clear
        tableView.center.y = self.center.y
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 2
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        return tableView
    }()
    
    fileprivate var path: IndexPath = IndexPath(row: 0, section: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        addSubview(tableView)
        addSubview(itemView)
        itemView.alpha = 0
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showView(){
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.tableView.frame.origin.x = 0
            self.tableView.backgroundColor = .clear
            self.alpha = 1
            UIApplication.shared.keyWindow?.addSubview(self)
        }) { (_) in
            self.itemView.alpha = 1
            self.isShow = true
            self.tableView(self.tableView, didSelectRowAt: self.path)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            self.updataItemView()
            self.itemView.alpha = 0;
        }) { (isOver) in
            if isOver{
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self.tableView.frame.origin.x = -120
                }, completion: { (_) in
                    self.alpha = 0
                    self.isShow = false
                    self.removeFromSuperview()
                })
            }
        }
    }

}

extension ListHeaderView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "index")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "index")
        }
        cell?.backgroundColor = .clear
        cell?.textLabel?.backgroundColor = .clear
        cell?.textLabel?.textColor = .white
        cell?.textLabel?.textAlignment = .center
        let type = listAry[indexPath.row]
        switch type {
        case .seep(_, let str):
            cell?.textLabel?.text = str
        case .font(_,let str):
            cell?.textLabel?.text = str
        case .fontSize(_, let str):
            cell?.textLabel?.text = str
        case .fontColor(_,let str):
            cell?.textLabel?.text = str
        case .bgColor(_,let str):
            cell?.textLabel?.text = str
        case .direction(_,let str):
            cell?.textLabel?.text = str
        case .isRepeat(_,let str):
            cell?.textLabel?.text = str
        case .filker(_,let str):
            cell?.textLabel?.text = str
        case .attribute(_, let str):
             cell?.textLabel?.text = str
        case .anthor(_, let str):
            cell?.textLabel?.text = str
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        guard let cell = tableView.cellForRow(at: indexPath) else {return }
        path = indexPath
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        itemView.frame = cell.convert(cell.bounds , to: self)
        let type = listAry[indexPath.row]
        switch type {
        case .seep(let ary, _):
            showItemView(cell: cell, width: 100, ary: ary as [AnyObject] , type: type)
        case .font(let ary, _):
            showItemView(cell: cell, width: 150, ary: ary as [AnyObject] , type: type)

        case .fontSize(let ary, _):
            showItemView(cell: cell, width: 180, ary: ary as [AnyObject] , type: type ,height: 60)

        case .fontColor(let ary, _):
            showItemView(cell: cell, width: 100, ary: ary as [AnyObject] , type: type)

        case .bgColor(let ary, _):
            showItemView(cell: cell, width: 100, ary: ary as [AnyObject] , type: type)

        case .direction(let ary, _):
            showItemView(cell: cell, width: 120, ary: ary as [AnyObject] , type: type)

        case .isRepeat(let ary, _):
            showItemView(cell: cell, width: 150, ary: ary as [AnyObject] , type: type)

        case .filker(let ary, _):
            showItemView(cell: cell, width: 150, ary: ary as [AnyObject] , type: type)
        case .attribute(let ary,_):
            showItemView(cell: cell, width: 180, ary: ary as [AnyObject] , type: type)
        case .anthor(let ary, _):
            showItemView(cell: cell, width: 180, ary: ary as [AnyObject] , type: type, height: 65)

        }
    }
    
    private func showItemView(cell: UITableViewCell, width: Int, ary: [AnyObject], type: ItmeType, height: Int = 44){
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.itemView.alpha = 1
            self.itemView.frame = CGRect(x: 100, y: 0, width: width, height: height * ary.count)
            self.itemView.center.y = cell.convert(cell.center , to: self).y - CGFloat(44 * self.path.row)
            self.itemView.ShowView(listAry:ary as [AnyObject], switchType: type)
        }, completion: nil)
    }
    
    private func updataItemView(){
        guard let cell = tableView.cellForRow(at: path) else {return }
        itemView.frame = cell.convert(cell.bounds , to: self)
    }
}


// MARK: -- Item
class ListItemView: UIView {
    
    var itemAry: [AnyObject] = []
    var type: ItmeType!
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: 100, height: itemAry.count * 44), style: UITableView.Style.plain)
        tableView.delegate  = self
        tableView.dataSource  = self
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        tableView.backgroundColor = .clear
        tableView.center.y = self.center.y
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 2
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        tableView.register(FontTypeCell.self, forCellReuseIdentifier: FontTypeCell.identifier)
        tableView.register(FontSizeCell.self, forCellReuseIdentifier: FontSizeCell.identifier)
        tableView.register(ColorCell.self, forCellReuseIdentifier: ColorCell.identifier)
        tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "index")
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        layer.cornerRadius = 5

        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ShowView(listAry: [AnyObject], switchType: ItmeType) {
        type = switchType
        itemAry = listAry
        tableView.frame = self.bounds
        tableView.reloadData()
    }
    
}

extension ListItemView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemAry.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "index")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "index")
        }
        guard let indexCell = cell else { return UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "index") }
        indexCell.textLabel?.text = "\(indexPath.row)"
        indexCell.textLabel?.textAlignment = .center
        indexCell.textLabel?.numberOfLines = 0
        let anyobj = itemAry[indexPath.row]
        switch type {
        case .seep(_, _)?:
              indexCell.textLabel?.text = "\(anyobj)"
        case .font(_,_)?:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FontTypeCell.identifier, for: indexPath) as? FontTypeCell {
                cell.fontType = anyobj as! String
                return cell
            }
        case .fontSize(_,_)?:
            if let cell = tableView.dequeueReusableCell(withIdentifier: FontSizeCell.identifier, for: indexPath) as? FontSizeCell {
                cell.fontSize = anyobj as! CGFloat
                return cell
            }
        case .fontColor(_,_)?:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell {
                cell.fontColor = anyobj as! UIColor
                return cell
            }
        case .bgColor(_,_)?:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell {
                cell.fontColor = anyobj as! UIColor
                cell.bgColor = 1
                return cell
            }
        case .direction(_,_)?:
            indexCell.textLabel?.text = anyobj as? String
        case .isRepeat(_,_)?:
            indexCell.textLabel?.text = anyobj as? String
        case .filker(_,_)?:
            indexCell.textLabel?.text = anyobj as? String
        case .attribute(_,_)?:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier, for: indexPath) as? SwitchCell {
                cell.labelText = anyobj as? String
                return cell
            }
        case .none:
            break
        case .some(.anthor(_, _)):
            indexCell.textLabel?.text = anyobj as? String
        }
        
        return indexCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0.0
        switch type {
        case .seep(_, _)?:
            height = 44
        case .font(_,_)?:
            height = 44
        case .fontSize(_,_)?:
            height = 60
        case .fontColor(_,_)?:
            height = 44
        case .bgColor(_,_)?:
            height = 44
        case .direction(_,_)?:
            height = 44
        case .isRepeat(_,_)?:
            height = 44
        case .filker(_,_)?:
            height = 44
        case .attribute(_,_)?:
            height = 44
        case .anthor(_,_)?:
            if indexPath.row == 0{
                height = 65
            }else{
                height = 155
            }
        default:
            height = 65
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let anyobj = itemAry[indexPath.row]
        switch type {
        case .seep(_, _)?:
            Config.makeConfig.speed = anyobj as! CGFloat
        case .font(_,_)?:
            Config.makeConfig.fontStyle = anyobj as! String
        case .fontSize(_,_)?:
            Config.makeConfig.fontSize = anyobj as! CGFloat
        case .fontColor(_,_)?:
            Config.makeConfig.textColor = anyobj as! UIColor
        case .bgColor(_,_)?:
            Config.makeConfig.bgColor = anyobj as! UIColor
        case .direction(_,_)?:
            let isDirection = indexPath.row == 0 ? true : false
            Config.makeConfig.isDirection = isDirection
            Config.makeConfig.saveValue(value: isDirection, key: direction)
        case .isRepeat(_,_)?:
            let isCycle = indexPath.row == 0 ? true : false
            Config.makeConfig.isCycle = isCycle
            Config.makeConfig.saveValue(value: isCycle, key: cycle)
        case .filker(_,_)?:
            let isFlicker = indexPath.row == 0 ? true : false
            Config.makeConfig.isFlicker = isFlicker
            Config.makeConfig.saveValue(value: isFlicker, key: flicker)
        case .anthor(_,_)?:
            if indexPath.row == 0{
                let productIdentifiers: Set<String> = ["com.dym.1"]
                StoreTool.makeInitialize.start(productIdentifiers: productIdentifiers, successBlock: { () -> Order in
                    return (productIdentifiers: productIdentifiers.first!, userName: "appStore")
                }, receiptBlock: { (receipt, transaction, queue) in
                    
                }) { (error) in
                    
                }
            }
        default:
            break
        }
    }
}

/*
 
 switch type {
 case .seep(_, let str):
 
 case .font(_,let str):
 
 case .fontSize(_, let str):
 
 case .fontColor(_,let str):
 
 case .bgColor(_,let str):
 
 case .direction(_,let str):
 
 case .isRepeat(_,let str):
 
 case .filker(_,let str):
 
 }
 
 switch type {
 case .seep(_, _):
 
 case .font(_,_):
 
 case .fontSize(_,_):
 
 case .fontColor(_,_):
 
 case .bgColor(_,_):
 
 case .direction(_,_):
 
 case .isRepeat(_,_):
 
 case .filker(_,_):
 
 }
 
 */
