//
//  CBConfiguration.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 12/09/2019.
//

import UIKit

public class CBConfiguration: NSObject {
    public var font:UIFont! = UIFont(name: "Helvetica", size: 18.0);
    public var baloonRadius:CGFloat = 30.0;
    public var thumbShadowColor:UIColor! = UIColor.blue;
    public var particleImageName:String? = nil;
    public var particleColors:Array<UIColor>! = [UIColor.blue, UIColor.green, UIColor.yellow];
    
    public var messageBackgroundColor:UIColor! = UIColor.lightGray;
    public var messageShadowColor:UIColor! = UIColor.red;
    public var messageTextColor:UIColor = UIColor.black;
    
    public var inputBackgroundColor:UIColor! = UIColor.yellow;
    public var inputTextColor:UIColor! = UIColor.black;
    
    public var answerBackgroundColor:UIColor! = UIColor.blue;
    public var answerTextColor:UIColor = UIColor.white;
    
    public var callToActionPrimaryColor:UIColor! = UIColor.blue;
    public var callToActionShadowColor:UIColor! = UIColor.yellow;
    public var callToActionTextColor:UIColor = UIColor.black;
    
    private static var defaultInstance:CBConfiguration!;
    
    public static func getDefaultConfiguration() -> CBConfiguration {
        if(defaultInstance == nil){
            defaultInstance = CBConfiguration();
        }
        return defaultInstance;
    }
    
    public static func setDefaultConfiguration(_ configuration:CBConfiguration) -> Void {
        defaultInstance = configuration;
    }
}
