//
//  CBItem.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 12/09/2019.
//

import UIKit

@objc public class CBItem: NSObject {
    @objc public var type:CBMessageType = CBMessageType(rawValue: 0)!;
    @objc public var category:CBCategory!;
    @objc public var text:String?;
    @objc public var botMessageId:NSNumber?;
    @objc public var options:Array<[String:Any]>?;
    @objc public var link:URL?;
    @objc public var action:Selector!;
    @objc public var target:UIViewController!;
    @objc public var userInfo:[String: Any]!;
    
    @objc public static func make(type: CBMessageType, category:CBCategory!, text:String? = nil, options:Array<[String:Any]>? = nil, link: URL? = nil, action: Selector? = nil, target: UIViewController? = nil, userInfo: [String: Any]? = nil,  botMessageId: NSNumber!) -> CBItem{
        let item:CBItem = CBItem();
        item.type = type;
        item.category = category;
        item.text = text;
        item.options = options;
        item.link = link;
        item.action = action;
        item.target = target;
        item.userInfo = userInfo;
        item.botMessageId = botMessageId;
        
        // coerence checks;
        switch type {
        case .onlyMessage:
            item.checkOnlyMessage();
            break;
        case .multipleChoice:
            break;
        case .callToAction:
            break;
        case .externalLink:
            break;
        }
        
        return item;
    }
    
    private func checkOnlyMessage() {
        if(text == nil){
            fatalError("text field required for .onlyMessage type");
        }
    }
    private func checkMultipleChoice() {
        if(options == nil){
            fatalError("options field required for .multipleChoice type");
        }else{
            if(options!.count == 0){
                fatalError("options field must contains 1 item at least");
            }
        }
    }
    private func checkCallToAction() {
        // TODO check
    }
    private func checkExternalLink() {
        if(link == nil){
            fatalError("link field required for externalLink type");
        }
    }
}
