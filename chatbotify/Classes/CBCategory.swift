//
//  CBCategory.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 12/09/2019.
//

import UIKit

@objc public class CBCategory: NSObject {
    @objc public var name:String!;
    @objc public var thumb:UIImage!;
    
    @objc public static func make(name:String!, thumb:UIImage!) -> CBCategory {
        let category:CBCategory = CBCategory();
        category.name = name;
        category.thumb = thumb;
        return category;
    }
}
