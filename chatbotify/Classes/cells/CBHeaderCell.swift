//
//  CBHeaderCell.swift
//  Chatbotify
//
//  Created by Vincenzo Romano on 01/10/2019.
//

import UIKit

class CBHeaderCell: UICollectionReusableView {
    
    var dateLabel:UILabel!;
    
    public func bind(_ date:Date!) {
        if(dateLabel == nil) {
            dateLabel = UILabel(frame: CGRect(x: 10, y: 5, width: self.frame.size.width - 20, height: self.frame.size.height - 10));
            
            dateLabel.textColor = CBConfiguration.getDefaultConfiguration().dateHeaderTextColor;
            dateLabel.backgroundColor = CBConfiguration.getDefaultConfiguration().dateHeaderTextColor.withAlphaComponent(0.2);
            dateLabel.layer.cornerRadius = dateLabel.frame.size.height / 2;
            dateLabel.textAlignment = .center;
            dateLabel.clipsToBounds = true;
            
            self.addSubview(dateLabel);
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "H:mm"

        let time = "\(dateFormatter.string(from: date)), \(timeFormatter.string(from: date))"
        dateLabel.text = time;
    }
    
    override func layoutSubviews() {
        if(dateLabel != nil) {
            dateLabel.sizeToFit();
            dateLabel.frame = CGRect(x: (self.frame.size.width - (dateLabel.frame.size.width + 40)) / 2, y: (self.frame.size.height - 40) / 2, width: dateLabel.frame.size.width + 40, height: 40);
            dateLabel.layer.cornerRadius = dateLabel.frame.size.height / 2;
        }
    }
}
