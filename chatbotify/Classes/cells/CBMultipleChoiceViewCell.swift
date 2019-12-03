//
//  CBMultipleChoiceViewCell.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 13/09/2019.
//

import UIKit

@available(iOS 10.0, *)
class CBMultipleChoiceViewCell: ChatbotifyCell {
    
    private var configuration:CBConfiguration!;
    private var item: CBItem!;
    
    private var content:UIView!;
    private let maxFloat:CGFloat = 0x1.fffffep+127;
    private var height:CGFloat = 0.0;
    
    private let topMargin:CGFloat = 10.0;
    private let horizontalMargin:CGFloat = 20.0;
    private let horizontalSpace:CGFloat = 10.0;
    private let verticalMargin:CGFloat = 15.0;
    
    private var optionButtons:Array<UIButton>!;
    private var heightConstraint:NSLayoutConstraint!;
    
    private var answer:UIButton!;
    private var emitterFirstLayer:CAEmitterLayer!;
    private var emitterSecondLayer:CAEmitterLayer!;
    
    public override func bind(isFirstOfSection: Bool, item: CBItem){
        self.configuration = CBConfiguration.getDefaultConfiguration();
        self.item = item;
        
        self.contentView.backgroundColor = UIColor.clear;
        
        if(content == nil) {
            content = UIView(frame: self.contentView.bounds);
            
            self.contentView.addSubview(content);
            
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: 0));
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 0));
            
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 0));
            self.contentView.addConstraint(NSLayoutConstraint(item: content, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 0));
        }
        
        self.content.subviews.forEach { (view) in
            view.removeFromSuperview();
        }
        
        var optLabel:UILabel;
        
        let screenWidth = UIScreen.main.bounds.size.width;
        var xPos:CGFloat = screenWidth - horizontalMargin;
        var yPos:CGFloat = topMargin;
        
        // CHECK if the question is already answered
        
        if(item.text != nil){
            optLabel = UILabel(frame: CGRect(x: 0, y: 0.0, width: 100.0, height: 45.0));
            optLabel.text = item.text;
            optLabel.textAlignment = NSTextAlignment.center;
            optLabel.font = configuration.font;
            
            let rect:CGRect = NSString(string: optLabel.text!).boundingRect(with: CGSize(width: maxFloat, height: 45.0), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: [NSAttributedStringKey.font:optLabel.font], context: nil);
            
            xPos = xPos - (rect.size.width + (2 * horizontalMargin) + horizontalSpace);
            if(xPos < horizontalMargin){
                xPos = screenWidth - horizontalMargin - (rect.size.width + (2 * horizontalMargin) + horizontalSpace);
                yPos = yPos + 45 + topMargin;
            }
            optLabel.frame = CGRect(x: xPos, y: yPos, width: rect.size.width + (2 * horizontalMargin), height: 45.0);
            
            answer = UIButton(type: UIButtonType.custom);
            answer.frame = optLabel.frame;
            answer.titleLabel!.font = optLabel.font;
            answer.backgroundColor = configuration.inputBackgroundColor;
            answer.setTitle(optLabel.text, for:UIControlState.normal);
            answer.setTitleColor(configuration.inputTextColor, for: UIControlState.normal);
            answer.layer.cornerRadius = answer.frame.size.height/2;
            
            answer.backgroundColor = configuration.answerBackgroundColor;
            answer.setTitleColor(configuration.answerTextColor, for: UIControlState.normal);
            answer.layer.cornerRadius = 0.0;
            
            let backgroundLayer:CAShapeLayer = CAShapeLayer();
            let path = UIBezierPath(roundedRect: answer.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: configuration.baloonRadius, height: configuration.baloonRadius))
            backgroundLayer.path = path.cgPath;
            answer.layer.mask = backgroundLayer;
            
            content.addSubview(answer);
            
            content.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: answer.frame.origin.y + answer.frame.size.height + topMargin);
            
            heightConstraint = NSLayoutConstraint(item: content, attribute: .height, relatedBy: .equal, toItem: content, attribute: .height, multiplier: 1, constant: content.frame.size.height);
            content.addConstraint(heightConstraint);
            
            return
        }
        
        // PROCEED only if not answered.
        
        optionButtons = Array();
        
        if(item.options!.count > 0){
            for i in 0...item.options!.count-1 {
                optLabel = UILabel(frame: CGRect(x: 0, y: topMargin, width: 100.0, height: 45.0));
                optLabel.text = (item.options![i]["text"] as! String);
                optLabel.textAlignment = NSTextAlignment.center;
                optLabel.font = configuration.font;
                
                let rect:CGRect = NSString(string: optLabel.text!).boundingRect(with: CGSize(width: maxFloat, height: 35.0), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: [NSAttributedStringKey.font:optLabel.font], context: nil);
                
                xPos = xPos - (rect.size.width + (2 * horizontalMargin) + horizontalSpace);
                if(xPos < horizontalMargin){
                    xPos = screenWidth - horizontalMargin - (rect.size.width + (2 * horizontalMargin) + horizontalSpace);
                    yPos = yPos + 45 + topMargin;
                }
                optLabel.frame = CGRect(x: xPos, y: yPos, width: rect.size.width + (2 * horizontalMargin), height: 45.0);
                
                let optButton:UIButton = UIButton(type: UIButtonType.custom);
                optButton.frame = optLabel.frame;
                optButton.titleLabel!.font = optLabel.font;
                optButton.backgroundColor = configuration.inputBackgroundColor;
                optButton.setTitle(optLabel.text, for:UIControlState.normal);
                optButton.setTitleColor(configuration.inputTextColor, for: UIControlState.normal);
                optButton.layer.cornerRadius = optButton.frame.size.height/2;
                optButton.tag = (i+1);
                optButton.addTarget(self, action: #selector(selectOption(_:)), for: .touchUpInside);
                
                optionButtons.append(optButton);
                
                height = yPos + 45;
                
                content.addSubview(optButton);
                content.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: optButton.frame.origin.y + optButton.frame.size.height + topMargin);
                
            }
        }
        
        heightConstraint = NSLayoutConstraint(item: content, attribute: .height, relatedBy: .equal, toItem: content, attribute: .height, multiplier: 1, constant: content.frame.size.height);
        content.addConstraint(heightConstraint);

    }
    
    @objc private func selectOption(_ sender: UIButton) {
        for i in 0...self.optionButtons.count-1 {
            UIView.animate(withDuration: 0.3, delay: 0.1*Double(i), options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.optionButtons[i].alpha = 0.0;
                self.layoutIfNeeded();
            }, completion: { (completed) in
                sender.removeTarget(self, action: #selector(self.selectOption(_:)), for: .touchUpInside);
                if(self.optionButtons[i] != sender){
                    self.optionButtons[i].removeFromSuperview();
                }
            })
        }
        
        answer = sender;
        item.text = answer.titleLabel?.text;
        NotificationCenter.default.post(name: NSNotification.Name("dataUpdate"), object: nil, userInfo: ["item": item]);
        createAnswer(answer, animate: true);
        self.performAction(sender);
    }
    
    private func createAnswer(_ answer: UIButton, animate: Bool) {
        answer.backgroundColor = configuration.answerBackgroundColor;
        answer.setTitleColor(configuration.answerTextColor, for: UIControlState.normal);
        answer.layer.cornerRadius = 0.0;
        
        let backgroundLayer:CAShapeLayer = CAShapeLayer();
        let path = UIBezierPath(roundedRect: answer.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: configuration.baloonRadius, height: configuration.baloonRadius))
        backgroundLayer.path = path.cgPath;
        answer.layer.mask = backgroundLayer;
        
        self.setAnswerButtonPosition(answer);
        
        content.addSubview(answer);
        content.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: answer.frame.origin.y + answer.frame.size.height + topMargin);
        if(heightConstraint == nil){
            heightConstraint = NSLayoutConstraint(item: content, attribute: .height, relatedBy: .equal, toItem: content, attribute: .height, multiplier: 1, constant: content.frame.size.height);
        }else{
            heightConstraint.constant = content.frame.size.height;
        }
        
        let delay:Double = (self.optionButtons == nil) ? 0.0 : Double(self.optionButtons.count-1);
        UIView.animate(withDuration: 0.3, delay: 0.1*delay, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.answer.alpha = 1.0;
        }) { (completed) in
            if(animate == true){
                self.makeEmitter();
                self.startEmitter();
                self.perform(#selector(self.stopEmitter), with: nil, afterDelay: 3.0);
            }
        };
    }
    
    private func makeEmitter() {
        let blue = makeEmitterCell(color: configuration!.particleColors[0], name: "blue");
        let green = makeEmitterCell(color: configuration!.particleColors[1], name: "green");
        let yellow = makeEmitterCell(color: configuration!.particleColors[2], name: "yellow");
        
        if(emitterFirstLayer == nil){
            emitterFirstLayer = CAEmitterLayer();
        }else{
            emitterFirstLayer.removeFromSuperlayer();
        }
        
        emitterFirstLayer.emitterPosition = CGPoint(x: answer.frame.origin.x + (answer.frame.size.width/3) , y: answer.center.y);
        emitterFirstLayer.emitterSize = CGSize(width: answer.frame.size.width * 4, height: answer.frame.size.height * 4);
        emitterFirstLayer.emitterCells = [blue, green, yellow];
        content.layer.insertSublayer(emitterFirstLayer, at: 0);
        
        
        if(emitterSecondLayer == nil){
            emitterSecondLayer = CAEmitterLayer();
        }else{
            emitterSecondLayer.removeFromSuperlayer();
        }
        
        emitterSecondLayer.emitterPosition = CGPoint(x: answer.frame.origin.x + (answer.frame.size.width*(2/3)) , y: answer.center.y);
        emitterSecondLayer.emitterSize = CGSize(width: answer.frame.size.width * 4, height: answer.frame.size.height * 4);
        emitterSecondLayer.emitterCells = [blue, green, yellow];
        content.layer.insertSublayer(emitterSecondLayer, at: 0);
    }
    
    func makeEmitterCell(color: UIColor, name: String) -> CAEmitterCell {
        let cell = CAEmitterCell();
        cell.name = name;
        cell.color = color.cgColor;
        cell.birthRate = 0;
        cell.lifetime = 0.6;
        cell.lifetimeRange = 0.6;
        cell.velocity = 50;
        cell.emissionRange = CGFloat(2 * Double.pi);
        cell.spin = 0.0;
        cell.spinRange = CGFloat(4 * Double.pi);
        cell.scale = 0.2;
        cell.scaleRange = 0.5;
        
        cell.contents = UIImage(named: configuration.particleImageName!)?.cgImage
        return cell
    }
    
    private func startEmitter() {
        emitterFirstLayer.setValue(70.0, forKeyPath: "emitterCells.blue.birthRate");
        emitterFirstLayer.setValue(70.0, forKeyPath: "emitterCells.green.birthRate");
        emitterFirstLayer.setValue(70.0, forKeyPath: "emitterCells.yellow.birthRate");
        
        emitterSecondLayer.setValue(70.0, forKeyPath: "emitterCells.blue.birthRate");
        emitterSecondLayer.setValue(70.0, forKeyPath: "emitterCells.green.birthRate");
        emitterSecondLayer.setValue(70.0, forKeyPath: "emitterCells.yellow.birthRate");
    }
    
    @objc private func stopEmitter() {
        emitterFirstLayer.setValue(0.0, forKeyPath: "emitterCells.blue.birthRate");
        emitterFirstLayer.setValue(0.0, forKeyPath: "emitterCells.green.birthRate");
        emitterFirstLayer.setValue(0.0, forKeyPath: "emitterCells.yellow.birthRate");
        
        emitterSecondLayer.setValue(0.0, forKeyPath: "emitterCells.blue.birthRate");
        emitterSecondLayer.setValue(0.0, forKeyPath: "emitterCells.green.birthRate");
        emitterSecondLayer.setValue(0.0, forKeyPath: "emitterCells.yellow.birthRate");
    }
    
    private func setAnswerButtonPosition(_ button:UIButton) {
        let rect:CGRect = NSString(string: button.titleLabel!.text!).boundingRect(with: CGSize(width: maxFloat, height: 35.0), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: [NSAttributedStringKey.font:button.titleLabel!.font!], context: nil);
        
        let screenWidth = UIScreen.main.bounds.size.width;
        var xPos:CGFloat = screenWidth - horizontalMargin;
        var yPos:CGFloat = 0.0;
        
        xPos = xPos - (rect.size.width + (2 * horizontalMargin) + horizontalSpace);
        if(xPos < horizontalMargin){
            xPos = screenWidth - horizontalMargin - (rect.size.width + (2 * horizontalMargin) + horizontalSpace);
        }
        
        yPos = (content.frame.size.height - button.frame.size.height)/2;
        
        button.frame = CGRect(x: xPos, y: yPos, width: rect.size.width + (2 * horizontalMargin), height: 45.0);
    }
    
    @objc private func performAction(_ sender: UIButton) {
        let r = item.options![0];
        if(self.delegate != nil) {
            self.delegate!.onResponseCompleted(botMessageId: item.botMessageId!, value: r["value"] as! String);
        }
        NotificationCenter.default.post(name: NSNotification.Name(r["value"] as! String), object: nil);
    }

}
