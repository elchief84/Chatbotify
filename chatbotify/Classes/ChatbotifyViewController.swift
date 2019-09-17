//
//  ChatbotifyViewController.swift
//  chatbotify
//
//  Created by Vincenzo Romano on 09/09/2019.
//

import UIKit

@available(iOS 10.0, *)
@objc open class ChatbotifyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet public var collectionView: UICollectionView!;
    private var layout:UICollectionViewFlowLayout!;
    
    private var messages:Array<CBGroup>!;
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func initController() {
        layout = UICollectionViewFlowLayout.init();
        layout.estimatedItemSize = CGSize(width: self.view.bounds.size.width-10, height: 10);
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        layout.scrollDirection = UICollectionViewScrollDirection.vertical;
        
        if(collectionView == nil){
            collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout);
            collectionView.backgroundColor = .white;
            self.view.addSubview(collectionView);
        }else{
            collectionView.setCollectionViewLayout(layout, animated: false);
        }
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView.register(UINib(nibName: "CBMessageViewCell", bundle: Bundle(for: ChatbotifyViewController.self)), forCellWithReuseIdentifier: "messageCell");
        collectionView.register(CBMultipleChoiceViewCell.self, forCellWithReuseIdentifier: "multipleChoiceCell");
        collectionView.register(CBExternalLinkCell.self, forCellWithReuseIdentifier: "externalLinkCell");
        collectionView.register(CBCallToActionCell.self, forCellWithReuseIdentifier: "callToActionCell");

        messages = Array<CBGroup>();
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDataUpdate(_ :)), name: NSNotification.Name("dataUpdate"), object: nil);
    }
    
    @objc private func onDataUpdate(_ notification:Notification) -> Void {
        // nothing TODO
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        NotificationCenter.default.removeObserver(self);
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        initController();
        
        
        let section = numberOfSections(in: collectionView) - 1;
        if(section >= 0){
            let item = collectionView.numberOfItems(inSection: section) - 1;
            let lastIndexPath = IndexPath(item: item, section: section);
        	collectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true);
        }
    }
    
    @objc public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return messages.count;
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages[section].items.count;
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item:CBItem = messages[indexPath.section].items![indexPath.row];
        
        let cell:ChatbotifyCell = ChatbotifyCell.dequeueReusableCell(type: item.type, collectionView: collectionView, indexPath: indexPath);
        cell.bind(isFirstOfSection: (indexPath.row == 0), item: item);
        
        return cell;
    }
    
    @objc public func push(_ group: CBGroup) {
        debugPrint(collectionView.contentSize.height);
        collectionView.performBatchUpdates({
            let section = messages.count;
            let set = IndexSet(integer: section);
            
            collectionView.insertSections(set)
            messages.append(group);
        }, completion: { (completion) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                debugPrint(self.collectionView.contentSize.height);
                let indexPath:IndexPath = IndexPath(row: self.messages[self.messages.count-1].items.count-1, section: self.messages.count-1);
                self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true);
            }
        });
        
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
