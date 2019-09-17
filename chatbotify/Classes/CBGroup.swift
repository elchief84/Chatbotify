//
//  CBGroup.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 12/09/2019.
//

import UIKit

public class CBGroup: NSObject {
    public var date:Date!;
    public var items:Array<CBItem>!;
    
    @objc public static func make(date: Date, items: Array<CBItem>? = Array()) -> CBGroup {
        let group:CBGroup = CBGroup();
        group.date = date;
        group.items = (items != nil) ? items : Array<CBItem>();
        return group;
    }
    
    @objc public func add(_ item: CBItem!) {
        self.items.append(item);
    }
    
    @objc public func insert(item: CBItem, at: Int) {
        items.insert(item, at: at);
    }
    
    @objc public func remove(_ item: CBItem!) {
        if let index = self.items.index(of: item) {
            self.items.remove(at: index);
        }
    }
}
