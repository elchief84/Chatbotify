//
//  ChatbotifyCell.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 09/09/2019.
//

import UIKit

@available(iOS 10.0, *)

@objc public protocol ChatbotifyCellDelegate{
    func onResponseCompleted(botMessageId:NSNumber, value:String);
}

@objc class ChatbotifyCell: UICollectionViewCell {
    
    @objc public var type:CBMessageType;
    public var message:CBGroup?;
    
    public var delegate:ChatbotifyCellDelegate?;
    public var caller:ChatbotifyViewController?;
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width);
        width.isActive = true;
        return width;
    }()
    
    init(type:CBMessageType) {
        self.type = type;
        super.init(frame: CGRect(x: 0, y: 0, width: 100.0, height: 50.0));
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = CBMessageType(rawValue: 0)!;
        super.init(coder: aDecoder);
    }
    
    override init(frame: CGRect) {
        self.type = CBMessageType(rawValue: 0)!;
        super.init(frame: frame);contentView.translatesAutoresizingMaskIntoConstraints = false;
        contentView.backgroundColor = UIColor.red;
        // setupViews();
    }
    
    override public func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }

    @objc public static func dequeueReusableCell(type: CBMessageType, collectionView: UICollectionView, indexPath: IndexPath) -> ChatbotifyCell {
        var reuseIdentifier:String = "";
        switch type {
            case .onlyMessage: reuseIdentifier = "messageCell"; break;
            case .multipleChoice: reuseIdentifier = "multipleChoiceCell"; break;
            case .externalLink: reuseIdentifier = "externalLinkCell"; break;
            case .callToAction: reuseIdentifier = "callToActionCell"; break;
        }
        return (collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ChatbotifyCell)!;
    }

    @objc public func bind(isFirstOfSection: Bool, item: CBItem){
        switch item.type {
        case .onlyMessage: (self as! CBMessageViewCell).bind(isFirstOfSection: isFirstOfSection, item: item); break;
        case .multipleChoice: (self as! CBMultipleChoiceViewCell).bind(isFirstOfSection: isFirstOfSection, item: item); break;
        case .externalLink: (self as! CBExternalLinkCell).bind(isFirstOfSection: isFirstOfSection, item: item); break;
        case .callToAction: (self as! CBCallToActionCell).bind(isFirstOfSection: isFirstOfSection, item: item); break;
        }
    }
}
