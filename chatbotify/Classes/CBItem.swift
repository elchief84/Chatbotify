//
//  CBItem.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 12/09/2019.
//

import UIKit

public class CBItem: NSObject {
    public var type:CBMessageType!;
    public var category:CBCategory!;
    public var text:String?;
    public var options:Array<String>?;
    public var link:URL?;
    public var sentByMe: Bool!;
    public var action:Selector!;
    public var target:UIViewController!;
    public var userInfo:[String: Any]!;
    
    public static func make(type: CBMessageType!, category:CBCategory!, text:String? = nil, options:Array<String>? = nil, link: URL? = nil, sentByMe:Bool! = false, action: Selector? = nil, target: UIViewController? = nil, userInfo: [String: Any]? = nil) -> CBItem{
        let item:CBItem = CBItem();
        item.type = type;
        item.category = category;
        item.text = text;
        item.options = options;
        item.link = link;
        item.sentByMe = sentByMe;
        item.action = action;
        item.target = target;
        item.userInfo = userInfo;
        
        // coerence checks;
        switch type! {
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
