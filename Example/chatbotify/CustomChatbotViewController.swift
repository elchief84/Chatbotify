//
//  CustomChatbotViewController.swift
//  chatbotify_Example
//
//  Created by Vincenzo Romano on 12/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import chatbotify

class CustomChatbotViewController: ChatbotifyViewController {

    private let categories:Array<CBCategory> = [
        CBCategory.make(name: "Spiderman", thumb: UIImage(named: "img_spiderman")),
        CBCategory.make(name: "Batman", thumb: UIImage(named: "img_batman")),
        CBCategory.make(name: "Hulk", thumb: UIImage(named: "img_hulk")),
        CBCategory.make(name: "Ironman", thumb: UIImage(named: "img_ironman"))];
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Override default configuration
        let configuration:CBConfiguration = CBConfiguration.getDefaultConfiguration();
        configuration.font = UIFont(name: "Quicksand-Medium", size: 18.0);
        configuration.particleImageName = "particle";
        configuration.particleColors = [CBCommons.makeColor(hexValue: 0xFF208FFF), CBCommons.makeColor(hexValue: 0xFFFFDF40), CBCommons.makeColor(hexValue: 0xFF1DD6A9)]
        configuration.messageTextColor = CBCommons.makeColor(hexValue: 0xFF555555);
        configuration.messageBackgroundColor = UIColor.white;
        configuration.messageShadowColor = CBCommons.makeColor(hexValue: 0xFF67A9E6);
        configuration.inputBackgroundColor = CBCommons.makeColor(hexValue: 0xFFFFDF40);
        configuration.inputTextColor = CBCommons.makeColor(hexValue: 0xFF555555);
        configuration.answerBackgroundColor = CBCommons.makeColor(hexValue: 0xFF208FFF);
        configuration.answerTextColor = CBCommons.makeColor(hexValue: 0xFFFFFFFF);
        CBConfiguration.setDefaultConfiguration(configuration);
        
        // fake message structures
        var group:CBGroup = CBGroup.make(date: Date());
        group.add(CBItem.make(type: .onlyMessage, category: categories[0], text: "Ciao"));
        group.add(CBItem.make(type: .onlyMessage, category: categories[0], text: "Non si intrometta! No, aspetti, mi porga l'indice; ecco lo alzi così... guardi, guardi, guardi; lo vede il dito? Lo vede che stuzzica, che prematura anche. E lei.. cosa si sente? Professore, non le dico."));
        push(group);
        
        group = CBGroup.make(date: Date());
        group.add(CBItem.make(type: .onlyMessage, category: categories[2], text: "Antani come trazione per due anche se fosse supercazzola bitumata, ha lo scappellamento a destra. Si, ma la sbiriguda della sbrindellona come se fosse antani come faceva? Prego?"));
        push(group);
        
        group = CBGroup.make(date: Date());
        group.add(CBItem.make(type: .onlyMessage, category: categories[1], text: "Ho capito. Tre applicazioni di afasol, di un'ora l'una. Subito!"));
        push(group);
        
        group = CBGroup.make(date: Date());
        group.add(CBItem.make(type: .multipleChoice, category: categories[3], options: ["la uno", "la due", "la tre", "la quattro", "la cinque", "la sei"]));
        push(group);
        
        group = CBGroup.make(date: Date());
        group.add(CBItem.make(type: .onlyMessage, category: categories[3], text: "Vuoi vedere un bel sito?"));
        group.add(CBItem.make(type: .externalLink, category: categories[3], text: "My personal website", link: URL(string: "http://www.enzoromano.eu")));
        push(group);
        
        group = CBGroup.make(date: Date());
        group.add(CBItem.make(type: .onlyMessage, category: categories[1], text: "Prova call to action?"));
        group.add(CBItem.make(type: .callToAction, category: categories[1], text: "Show Alert", action:#selector(showAlert(_:)), target: self, userInfo:["titletext":"Hello!", "bodytext": "Ciao come stai?"]));
        push(group);
    }
    
    @IBAction func onPush(_ sender: Any) {
        let group:CBGroup = CBGroup.make(date: Date());
        group.add(CBItem.make(type: .onlyMessage, category: categories[0], text: "Non si intrometta! No, aspetti, mi porga l'indice; ecco lo alzi così... guardi, guardi, guardi; lo vede il dito?"));
        group.add(CBItem.make(type: .onlyMessage, category: categories[0], text: "Lo vede che stuzzica, che prematura anche."));
        group.add(CBItem.make(type: .multipleChoice, category: categories[3], options: ["la uno", "la due", "la tre", "la quattro", "la cinque", "la sei"]));
        push(group);
    }
    
    @objc private func showAlert(_ userInfo:[String: Any]) {
        let alert:UIAlertController = UIAlertController.init(title: userInfo["titletext"] as? String, message: userInfo["bodytext"] as? String, preferredStyle: UIAlertControllerStyle.alert);
        alert.addAction(UIAlertAction.init(title: "Close", style: UIAlertActionStyle.destructive, handler: nil));
        self.present(alert, animated: true, completion: nil);
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
