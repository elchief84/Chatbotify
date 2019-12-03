//
//  CBCommons.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 09/09/2019.
//

import UIKit

@objc public enum CBMessageType: NSInteger {
    case onlyMessage = 0
    case multipleChoice = 1
    case externalLink = 3
    case callToAction = 2
}

@objc public class CBCommons: NSObject {

    @objc public static func makeColor(hexValue: Int) -> UIColor {
        return UIColor.init(red: CGFloat((hexValue >> 16) & 0xFF)/255.0, green: CGFloat((hexValue >> 8) & 0xFF)/255.0, blue: CGFloat(hexValue & 0xFF)/255.0, alpha: CGFloat((hexValue >> 24) & 0xFF)/255.0);
    }
    
}
