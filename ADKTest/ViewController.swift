//
//  ViewController.swift
//  ADKTest
//
//  Created by John Tumminaro on 12/18/15.
//  Copyright © 2015 John Tumminaro. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ImageNode: ASCellNode {
    
    let imageNode = ASImageNode()
    override init!() {
        super.init()
        imageNode.image = UIImage(color: UIColor.blueColor(), size: CGSizeMake(100, 100))
        addSubnode(imageNode)
    }
    
    
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec! {
        return ASInsetLayoutSpec(insets: UIEdgeInsetsZero, child: imageNode)
    }
    
}

class ViewController: ASViewController, ASCollectionViewDataSource, ASCollectionViewDelegate, ASCollectionViewDelegateFlowLayout {
    
    var collectionView: ASCollectionView { return (node as! ASCollectionNode).view }
    
    init() {
        let colNode = ASCollectionNode(collectionViewLayout: UICollectionViewFlowLayout())
        colNode.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        super.init(node: colNode)
        collectionView.asyncDataSource = self
        collectionView.asyncDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: ASCollectionView!, nodeForItemAtIndexPath indexPath: NSIndexPath!) -> ASCellNode! {
        return ImageNode()
    }
    
    func collectionView(collectionView: ASCollectionView!, constrainedSizeForNodeAtIndexPath indexPath: NSIndexPath!) -> ASSizeRange {
        return ASSizeRangeMake(CGSizeMake(100, 100), CGSizeMake(300, 300))
    }
    
    func collectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension UIImage {
    convenience init?(color:UIColor, size:CGSize = CGSizeMake(10, 10) ) {
        if size.height != 0.0 && size.width != 0.0 {
            let rect = CGRectMake(0, 0, size.width, size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            color.setFill()
            UIRectFill(rect)
            guard let img = UIGraphicsGetImageFromCurrentImageContext().CGImage else { return nil }
            self.init(CGImage: img)
            UIGraphicsEndImageContext()
        } else {
            self.init()
        }
    }
}
