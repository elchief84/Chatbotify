//
//  CBCallToActionCell.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 16/09/2019.
//

import UIKit

@available(iOS 10.0, *)
class CBCallToActionCell: ChatbotifyCell {
    
    private var configuration:CBConfiguration!;
    private var item: CBItem!;
    
    private var content:UIView!;
    
    private let maxFloat:CGFloat = 0x1.fffffep+127;
    private var height:CGFloat = 0.0;
    private var heightConstraint:NSLayoutConstraint!;
    
    private let topMargin:CGFloat = 20.0;
    private let horizontalMargin:CGFloat = 20.0;
    private let horizontalSpace:CGFloat = 10.0;
    private let verticalMargin:CGFloat = 15.0;
    
    public override func bind(isFirstOfSection: Bool, item: CBItem){
        self.configuration = CBConfiguration.getDefaultConfiguration();
        self.item = item;
        
        self.contentView.backgroundColor = UIColor.clear;
        
        if(content == nil) {
            content = UIView(frame: self.contentView.bounds);
            
            self.contentView.addSubview(content);
            
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: 0));
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 0));
            
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 10));
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 10));
        }
        
        self.content.subviews.forEach { (view) in
            view.removeFromSuperview();
        }
        
        var optLabel:UILabel;
        
        let screenWidth = UIScreen.main.bounds.size.width;
        var xPos:CGFloat = screenWidth - horizontalMargin;
        
        item.text = (item.text != nil) ? item.text : ((item.options!.count > 0) ? item.options![0] : "link");

        optLabel = UILabel(frame: CGRect(x: 0, y: 0.0, width: 100.0, height: 45.0));
        optLabel.text = item.text;
        optLabel.textAlignment = NSTextAlignment.center;
        optLabel.font = configuration.font;
        
        let rect:CGRect = NSString(string: optLabel.text!).boundingRect(with: CGSize(width: maxFloat, height: 45.0), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: [NSAttributedStringKey.font:optLabel.font], context: nil);
        
        xPos = xPos - (rect.size.width + (2 * horizontalMargin) + horizontalSpace);
        optLabel.frame = CGRect(x: xPos, y: topMargin, width: rect.size.width + (2 * horizontalMargin), height: 45.0);
        
        let button:UIButton = UIButton(type: UIButtonType.custom);
        button.frame = optLabel.frame;
        button.titleLabel!.font = optLabel.font;
        button.backgroundColor = configuration.inputBackgroundColor;
        button.setTitle(optLabel.text, for:UIControlState.normal);
        button.setTitleColor(configuration.inputTextColor, for: UIControlState.normal);
        button.layer.cornerRadius = button.frame.size.height/2;
        button.addTarget(self, action: #selector(performAction(_:)), for: .touchUpInside);
        
        content.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: button.frame.origin.y + button.frame.size.height + topMargin);
        
        heightConstraint = NSLayoutConstraint(item: content, attribute: .height, relatedBy: .equal, toItem: content, attribute: .height, multiplier: 1, constant: button.frame.size.height);
        content.addConstraint(heightConstraint);
        
        content.addSubview(button);
    }
    
    @objc private func performAction(_ sender: UIButton) {
        item.target.perform(item.action, with: item.userInfo);
    }
    
}
