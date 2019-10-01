//
//  CBConfiguration.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 12/09/2019.
//

import UIKit

@objc public class CBConfiguration: NSObject {
    @objc public var font:UIFont! = UIFont(name: "Helvetica", size: 18.0);
    @objc public var baloonRadius:CGFloat = 30.0;
    @objc public var thumbShadowColor:UIColor! = UIColor.blue;
    @objc public var particleImageName:String? = nil;
    @objc public var particleColors:Array<UIColor>! = [UIColor.blue, UIColor.green, UIColor.yellow];
    
    @objc public var messageBackgroundColor:UIColor! = UIColor.lightGray;
    @objc public var messageShadowColor:UIColor! = UIColor.red;
    @objc public var messageTextColor:UIColor = UIColor.black;
    
    @objc public var inputBackgroundColor:UIColor! = UIColor.yellow;
    @objc public var inputTextColor:UIColor! = UIColor.black;
    
    @objc public var answerBackgroundColor:UIColor! = UIColor.blue;
    @objc public var answerTextColor:UIColor = UIColor.white;
    
    @objc public var callToActionPrimaryColor:UIColor! = UIColor.blue;
    @objc public var callToActionShadowColor:UIColor! = UIColor.yellow;
    @objc public var callToActionTextColor:UIColor = UIColor.black;
    
    @objc public var dateHeaderTextColor:UIColor = UIColor.blue;
    
    private static var defaultInstance:CBConfiguration!;
    
    @objc public static func getDefaultConfiguration() -> CBConfiguration {
        if(defaultInstance == nil){
            defaultInstance = CBConfiguration();
        }
        return defaultInstance;
    }
    
    @objc public static func setDefaultConfiguration(_ configuration:CBConfiguration) -> Void {
        defaultInstance = configuration;
    }
}
