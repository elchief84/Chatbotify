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
    @objc public var caller: UIViewController?;
    private var layout:UICollectionViewFlowLayout!;
    
    private var messages:Array<CBGroup>!;
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func initController() {
        
        if(layout == nil){
            layout = UICollectionViewFlowLayout.init();
            layout.estimatedItemSize = CGSize(width: self.view.bounds.size.width-10, height: 10);
            layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1);
            layout.minimumLineSpacing = 1.0;
            layout.minimumInteritemSpacing = 1.0;
            layout.scrollDirection = UICollectionViewScrollDirection.vertical;
        }
        
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
        collectionView.register(CBHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell");

        if(messages == nil){
            messages = Array<CBGroup>();
        }
    }
    
    @objc private func onDataUpdate(_ notification:Notification) -> Void {
        // nothing TODO
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDataUpdate(_ :)), name: NSNotification.Name("dataUpdate"), object: nil);
        
        initController();
        collectionView.reloadData() // DEBUG;
        
        let section = numberOfSections(in: collectionView) - 1;
        if(section >= 0){
            let item = collectionView.numberOfItems(inSection: section) - 1;
            let lastIndexPath = IndexPath(item: item, section: section);
        	collectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true);
        }
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        NotificationCenter.default.removeObserver(self);
    }
    
    @objc public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return messages.count;
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages[section].items.count;
    }

    @objc public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:collectionView.frame.size.width, height:80.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath as IndexPath) as! CBHeaderCell;
            headerView.bind(messages[indexPath.section].date);
            return headerView;
        }
        
        fatalError("Unexpected element kind");
    }
    
    @objc public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item:CBItem = messages[indexPath.section].items![indexPath.row];
        let cell:ChatbotifyCell = ChatbotifyCell.dequeueReusableCell(type: item.type, collectionView: collectionView, indexPath: indexPath);
        cell.bind(isFirstOfSection: (indexPath.row == 0), item: item);
        
        if(caller != nil){
            cell.message = messages[indexPath.section];
            cell.caller = self;
            cell.delegate = (caller as! ChatbotifyCellDelegate);
        }
        
        return cell;
    }
    
    @objc public func push(_ group: CBGroup) {
        collectionView.performBatchUpdates({
            let section = messages.count;
            let set = IndexSet(integer: section);
            
            collectionView.insertSections(set)
            messages.append(group);
        }, completion: { (completion) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let indexPath:IndexPath = IndexPath(row: self.messages[self.messages.count-1].items.count-1, section: self.messages.count-1);
                self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true);
            }
        });
        
    }
    
    @objc public func remove(_ group: CBGroup) {
        messages.remove(at: messages.index(of: group)!);
    }
    
    @objc public func clear() {
        messages = Array();
        if(collectionView != nil){
            collectionView.reloadData();
        }
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
