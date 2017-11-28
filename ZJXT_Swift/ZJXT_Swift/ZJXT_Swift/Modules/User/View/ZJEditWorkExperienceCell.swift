//
//  ZJEditWorkExperienceCell.swift
//  ZJXT_Swift
//
//  Created by User on 2017/9/14.
//  Copyright © 2017年 runer. All rights reserved.
//

enum FormCellStyle:Int
{
    case input = 0
    case tap
    case info
}

class ZJEditWorkExperienceCell: BaseTableViewCell
{
    var style:FormCellStyle = .input{
        didSet{
            if style == .input
            {
                self.textField.isUserInteractionEnabled = true
            }
            else
            {
                self.textField.isUserInteractionEnabled = false
            }
        }
    }

    fileprivate lazy var imgView:UIImageView = {
        let imgView = UIImageView(image: IconFontUtils.imageSquare(code: "\u{e6d8}", size: 22, color: kTabbarBlueColor))
        return imgView
    }()
    
    lazy var textField:UITextField = {
        
        let textField = UITextField()
        textField.textColor = UIColor.color(hex: "#666666")
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.bottomLineStyle = .left
        self.accessoryType = .none
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.textField)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.imgView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(kHomeEdgeSpace*1.5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
        }
        self.textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.imgView.snp.right).offset(kHomeEdgeSpace)
            make.right.equalToSuperview().offset(-kHomeEdgeSpace*1.5)
        }
        
    }
    
    //MARK:- 类方法实例化
    static fileprivate let CELLID = "ZJEditWorkExperienceCell"
    class func cellWithTableView(_ tableView:UITableView) -> ZJEditWorkExperienceCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: CELLID) as? ZJEditWorkExperienceCell
        if cell == nil
        {
            cell = ZJEditWorkExperienceCell(style: UITableViewCellStyle.default, reuseIdentifier: CELLID)
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
