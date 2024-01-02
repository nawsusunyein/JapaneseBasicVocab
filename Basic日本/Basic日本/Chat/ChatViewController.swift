//
//  ChatViewController.swift
//  Basic日本
//
//  Created by Naw Su Su Nyein on 01/01/2024.
//  Copyright © 2024 Naw Su Su Nyein. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView

class ChatViewController: MessagesViewController {

    // メッセージリスト
       private var messageList: [ChatMessage] = [] {
           // メッセージ設定時に呼ばれる
           didSet {
               messagesCollectionView.reloadData()
               messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
           }
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
                   // メッセージリストの初期化
                   self.messageList = [
                       ChatMessage.new(sender: ChatSender.me, message: "こんにちは。"),
                       ChatMessage.new(sender: ChatSender.other, message: "はい、こんにちは。"),
                       ChatMessage.new(sender: ChatSender.me, message: "はい、今日は良い天気ですね！"),
                       ChatMessage.new(sender: ChatSender.other, message: "今日は良い天気ですね！")
                   ]
               }
               
               // messagesCollectionView
               messagesCollectionView.backgroundColor = UIColor.white
               messagesCollectionView.messagesDataSource = self
               messagesCollectionView.messagesLayoutDelegate = self
               messagesCollectionView.messagesDisplayDelegate = self
               
               // messageInputBar
               messageInputBar.delegate = self
               messageInputBar.sendButton.title = nil
               messageInputBar.sendButton.image = UIImage(named: "next")
                messageInputBar.leftStackView.alignment = .center
                messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
    }
    
    func initVC(username : String?, id : String?, chatStatus : String?) {
        print("username : \(username), id : \(id), chat status : \(chatStatus)")
    }
    
}


public struct Sender : SenderType {
    public let senderId: String
    public let displayName: String
}

public struct ChatSender : SenderType {
    public var senderId: String
    public var displayName: String
    public var iconName :  String
    
    static var me : ChatSender {
        return ChatSender(senderId: "0", displayName: "me", iconName: "cat")
    }
    
    static var other : ChatSender {
        return ChatSender(senderId: "1", displayName: "other", iconName: "bear")
    }
}

struct ChatMessage : MessageType {
    var sender: SenderType
    var messageId: String
    var kind: MessageKind
    var sentDate: Date
    
    static func new(sender: SenderType, message: String) -> ChatMessage {
          return ChatMessage(
              sender: sender,
              messageId: UUID().uuidString,
              kind: .attributedText(NSAttributedString(
                  string: message,
                  attributes: [
                      .font: UIFont.systemFont(ofSize: 14.0),
                      .foregroundColor: sender.senderId == "0" ? UIColor.white : UIColor.red
                  ]
              )),
              sentDate: Date())
      }
}

extension ChatViewController : MessagesDataSource {
    func currentSender() -> MessageKit.SenderType {
        return ChatSender.me
    }
    
       // メッセージ数
       func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
           return messageList.count
       }

       // IndexPathに応じたメッセージ
       func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
           return messageList[indexPath.section]
       }

       // messageTopLabelの属性テキスト
       func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
           return NSAttributedString(
               string: messageList[indexPath.section].sender.displayName,
               attributes: [.font: UIFont.systemFont(ofSize: 12.0), .foregroundColor: UIColor.systemBlue])
       }

       // messageBottomLabelの属性テキスト
       func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = DateFormatter.dateFormat(
               fromTemplate: "HH:mm", options: 0, locale: Locale(identifier: "ja_JP"))
           return NSAttributedString(
               string: dateFormatter.string(from: messageList[indexPath.section].sentDate),
               attributes: [.font: UIFont.systemFont(ofSize: 12.0), .foregroundColor: UIColor.red])
       }
}

// MessagesDisplayDelegate
extension ChatViewController: MessagesDisplayDelegate {
    // 背景色
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor.blue : UIColor.green
    }

    // メッセージスタイル
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }

    // avaterViewの設定
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = messageList[indexPath.section].sender as! ChatSender
        avatarView.image =  UIImage(named: sender.iconName)
    }
}

// MessagesLayoutDelegate
extension ChatViewController: MessagesLayoutDelegate {
    // messageTopLabelの高さ
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 24
    }

    // messageBottomLabelの高さ
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 24
    }
    
    // headerViewのサイズ
    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize.zero
    }
}

// InputBarAccessoryViewDelegate
extension ChatViewController: InputBarAccessoryViewDelegate {
    // InputBarAccessoryViewの送信ボタン押下時に呼ばれる
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        messageList.append(ChatMessage.new(sender: ChatSender.me, message: text))
        messageInputBar.inputTextView.text = String()
    }
}
