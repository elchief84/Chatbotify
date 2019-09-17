//
//  CBCategory.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 12/09/2019.
//

import UIKit

public class CBCategory: NSObject {
    public var name:String!;
    public var thumb:UIImage!;
    
    public static func make(name:String!, thumb:UIImage!) -> CBCategory {
        let category:CBCategory = CBCategory();
        category.name = name;
        category.thumb = thumb;
        return category;
    }
}
