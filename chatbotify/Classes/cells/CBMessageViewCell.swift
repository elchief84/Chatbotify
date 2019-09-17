//
//  CBMessageView.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 09/09/2019.
//

import UIKit

@available(iOS 10.0, *)
class CBMessageViewCell: ChatbotifyCell {
    
    @IBOutlet weak var imageWrapper: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageWrapper: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var configuration:CBConfiguration!;
    private var backgroundLayer:CAShapeLayer!;
    private var item: CBItem!;
    
    public override func bind(isFirstOfSection: Bool, item: CBItem){
        self.configuration = CBConfiguration.getDefaultConfiguration();
        self.item = item;
        
        self.drawBaloon();
        imageWrapper.isHidden = !isFirstOfSection;
        messageLabel.text = item.text;
    }
    
    private func drawBaloon() {
        
        // messageWrapper.layer.cornerRadius = configuration.baloonRadius;
        
        // Shadow THUMB
        imageWrapper.layer.backgroundColor = UIColor.clear.cgColor;
        imageWrapper.layer.shadowOffset = CGSize(width: 0.0, height: 5.0);
        imageWrapper.layer.shadowRadius = 6.0;
        imageWrapper.layer.shadowOpacity = 0.25;
        imageWrapper.layer.shadowColor = configuration.thumbShadowColor.cgColor;
        imageWrapper.layer.rasterizationScale = UIScreen.main.scale;
        imageWrapper.layer.shouldRasterize = true;
        
        // Settings THUMB
        imageView.image = item.category.thumb;
        
        // Shadow MESSAGE
        messageWrapper.backgroundColor = .clear;
        messageWrapper.layer.backgroundColor = UIColor.clear.cgColor;
        messageWrapper.layer.shadowOffset = CGSize(width: 0.0, height: 0.0);
        messageWrapper.layer.shadowRadius = 6.0;
        messageWrapper.layer.shadowOpacity = 0.25;
        messageWrapper.layer.shadowColor = configuration.messageShadowColor.cgColor;
        messageWrapper.layer.rasterizationScale = UIScreen.main.scale;
        messageWrapper.layer.shouldRasterize = true;
        
        // Settings MESSAGE
        messageLabel.textColor = configuration.messageTextColor;
        messageLabel.font = configuration.font;
        messageLabel.layer.rasterizationScale = UIScreen.main.scale; // not working
        messageLabel.layer.shouldRasterize = true;
        
        // Corners
        roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: configuration.baloonRadius);
        
    }
    
    private func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if(backgroundLayer != nil) {
            backgroundLayer.removeFromSuperlayer();
            backgroundLayer = nil;
        }
        backgroundLayer = CAShapeLayer();
        let path = UIBezierPath(roundedRect: messageWrapper.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        backgroundLayer.path = path.cgPath;
        backgroundLayer.fillColor = configuration.messageBackgroundColor.cgColor;
        messageWrapper.layer.insertSublayer(backgroundLayer, at: 0);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        messageWrapper.layoutIfNeeded();
        
        roundCorners(corners: [.topLeft, .topRight, .bottomRight], radius: configuration.baloonRadius);
    }

}
