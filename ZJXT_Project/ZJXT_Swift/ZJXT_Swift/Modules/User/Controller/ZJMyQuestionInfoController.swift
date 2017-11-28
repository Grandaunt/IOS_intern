//
//  ZJMyQuestionInfoController.swift
//  ZJXT_Swift
//
//  Created by User on 2017/11/3.
//  Copyright © 2017年 runer. All rights reserved.
//

import UIKit
import MessageKit
import MapKit
import IQKeyboardManager

class ZJMyQuestionInfoController: ZJMessageController
{

    var model:ZJMyQuestionModel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        IQKeyboardManager.shared().isEnabled = false
        self.initView()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    fileprivate func initView()
    {
        self.title = "问题详情"
        let topView = UIView()
        topView.backgroundColor = kBackgroundColor

        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(kStatusHeight + kNavigationBarHeight)
        }

        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.textColor = UIColor.color(hex: "#333333")
        infoLabel.font = UIFont.systemFont(ofSize: 15)
        infoLabel.text = self.model?.questionTitle
        topView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }

        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.color(hex: "#929292")
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.text = "提问人：" + (UserInfo.shard.trueName ?? "")
        topView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }

        let timeLabel = UILabel()
        timeLabel.textColor = UIColor.color(hex: "#929292")
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.text = self.model?.questionTime
        timeLabel.textAlignment = .right
        topView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(15)

        }

        self.messagesCollectionView.snp.remakeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messagesCollectionView.messageCellDelegate = self
        self.messageInputBar.delegate = self
        self.messageInputBar.sendButton.setTitle("发送", for: .normal)
        self.messageInputBar.inputTextView.placeholder = "新消息"
        self.messageInputBar.sendButton.tintColor = UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1)
        self.scrollsToBottomOnFirstLayout = true //default false
        self.scrollsToBottomOnKeybordBeginsEditing = true // default false
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}

extension ZJMyQuestionInfoController:MessagesDataSource
{
    func currentSender() -> Sender
    {
        return Sender(id: UserInfo.shard.userId ?? "", displayName: UserInfo.shard.trueName ?? "")
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int
    {
        return (self.model?.questionAnswerList?.count)!
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType
    {
        
        let m = self.model?.questionAnswerList![indexPath.section]
        let timeStr = m?.answerTime
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        var time = formatter.date(from: timeStr!)
        
        //因为后台时间格式不一致
        if time == nil
        {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            time = formatter.date(from: timeStr!)
        }
        
        let sender = Sender(id: m?.answerUserId ?? "", displayName: m?.answerUserName ?? "")
        let message = ZJQuestionMessage(text: m?.answerDes ?? "", sender: sender, messageId: m?.answerId ?? "", date: time!)
        return message
    }
    
    func avatar(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Avatar
    {
        let m = self.model?.questionAnswerList![indexPath.section]
        if m?.answerUserId == UserInfo.shard.userId
        {
            if UserInfo.shard.logo?.trimAfterCount() != 0
            {
                do
                {
                    let imgData = try Data(contentsOf: URL(string: UserInfo.shard.logo!)!)
                    
                    return Avatar(image: UIImage(data: imgData), initals: (m?.answerUserName)!)
                    
                    
                }catch
                {
                    
                }
            }
        }
        return Avatar(image: kUserLogoPlaceHolder, initals: (m?.answerUserName)!)
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?
    {
        let name = message.sender.displayName
        return NSAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString?
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(string: dateString, attributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .caption2)])
    }
}

extension ZJMyQuestionInfoController: MessagesDisplayDelegate, TextMessageDisplayDelegate
{
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    {
        return isFromCurrentSender(message: message) ? UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1) : UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor
    {
        return isFromCurrentSender(message: message) ? .white : .darkText
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle
    {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
        //        let configurationClosure = { (view: MessageContainerView) in}
        //        return .custom(configurationClosure)
    }
}

extension ZJMyQuestionInfoController: MessagesLayoutDelegate {
    
    func messagePadding(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIEdgeInsets
    {
        if isFromCurrentSender(message: message)
        {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 4)
        }
        else
        {
            return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 30)
        }
    }
    
    func cellTopLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment
    {
        if isFromCurrentSender(message: message)
        {
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        }
        else
        {
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
    }
    
    func cellBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment
    {
        if isFromCurrentSender(message: message)
        {
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        }
        else
        {
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        }
    }
    
    func avatarAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> AvatarAlignment
    {
        return .messageBottom
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize
    {
        
        return CGSize(width: messagesCollectionView.bounds.width, height: 10)
    }
    
}

// MARK: - LocationMessageLayoutDelegate

extension ZJMyQuestionInfoController: LocationMessageLayoutDelegate
{
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    {
        return 200
    }
    
}

// MARK: - MediaMessageLayoutDelegate

extension ZJMyQuestionInfoController: MediaMessageLayoutDelegate {}

// MARK: - MessageCellDelegate

extension ZJMyQuestionInfoController: MessageCellDelegate {
    
    func didTapAvatar<T>(in cell: MessageCollectionViewCell<T>)
    {
        log.info("点击头像")
    }
    
    func didTapMessage<T>(in cell: MessageCollectionViewCell<T>)
    {
        log.info("点击信息")
    }
}

// MARK: - MessageLabelDelegate

extension ZJMyQuestionInfoController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String : String])
    {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date)
    {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String)
    {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL)
    {
        print("URL Selected: \(url)")
    }
    
}

// MARK: - LocationMessageDisplayDelegate

extension ZJMyQuestionInfoController: LocationMessageDisplayDelegate
{
    
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView?
    {
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        let pinImage = #imageLiteral(resourceName: "pin")
        annotationView.image = pinImage
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        return annotationView
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)?
    {
        return { view in
            view.layer.transform = CATransform3DMakeScale(0, 0, 0)
            view.alpha = 0.0
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
                view.alpha = 1.0
            }, completion: nil)
        }
    }
    
}

// MARK: - MessageInputBarDelegate

extension ZJMyQuestionInfoController: MessageInputBarDelegate
{
    //点击发送按钮
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String)
    {
        var param = [String:Any]()
        param["answerUserId"] = UserInfo.shard.userId
        param["answerQuestionId"] = self.model?.questionId
        param["answerDes"] = text
        BaseViewModel().post(url: kAnswerQuestionURL, param: param, MBProgressHUD: false, success: { (resp) in
            var array = self.model?.questionAnswerList
            let model = ZJMyQuestionAnswerModel()
            model.answerDes = text
            model.answerUserName = UserInfo.shard.trueName
            model.answerUserId = UserInfo.shard.userId
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            model.answerTime = formatter.string(from: Date())
            array?.append(model)
            self.model?.questionAnswerList = array
            inputBar.inputTextView.text = String()
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToBottom()
        }, noData: nil, failure: nil)
        
    }
    
}
