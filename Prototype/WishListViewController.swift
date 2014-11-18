//
//  WishListViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

let votingReject: CGFloat = 480
let votingAccept: CGFloat = 160

class WishListViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {    
    @IBOutlet weak var swipeRightImage: UIImageView!
    @IBOutlet weak var swipeRightGreenImage: UIImageView!
    @IBOutlet weak var swipeLeftImage: UIImageView!
    @IBOutlet weak var swipeLeftRedImage: UIImageView!
    
    @IBOutlet weak var swipeButton: UIScrollView!
    @IBOutlet weak var swipeButton2: UIScrollView!
    @IBOutlet weak var swipeButton3: UIScrollView!
    @IBOutlet weak var swipeButton4: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeButton.contentSize = swipeButton.subviews[0].size!
        swipeButton.contentOffset.x = 320
        swipeButton2.contentSize = swipeButton2.subviews[0].size!
        swipeButton2.contentOffset.x = 320
        swipeButton3.contentSize = swipeButton2.subviews[0].size!
        swipeButton3.contentOffset.x = 320
        swipeButton4.contentSize = swipeButton2.subviews[0].size!
        swipeButton4.contentOffset.x = 320
        
        swipeButton.tag = 0
        swipeButton2.tag = 1
        swipeButton3.tag = 2
        swipeButton4.tag = 3
        
        swipeRightImage.layer.opacity = 0
        swipeLeftImage.layer.opacity = 0
        swipeRightGreenImage.layer.opacity = 0
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTouchSwipeButton(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended {
            UIView.animateWithDuration(0.5, delay: 0.5, options: nil, animations: {
                self.swipeRightImage.layer.opacity = 0
                self.swipeLeftImage.layer.opacity = 0
            }, completion: nil)
        }
        else {
            UIView.animateWithDuration(0.5, animations: {
                self.swipeRightImage.layer.opacity = 1
                self.swipeLeftImage.layer.opacity = 1
            })
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let vote = scrollView.contentOffset.x
        if vote >= votingReject {
            swipeRightGreenImage.layer.opacity = 0
            swipeLeftRedImage.layer.opacity = 1
        }
        else if vote <= votingAccept {
            swipeRightGreenImage.layer.opacity = 1
            swipeLeftRedImage.layer.opacity = 0
        }
        else {
            swipeRightGreenImage.layer.opacity = 0
            swipeLeftRedImage.layer.opacity = 0
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.x <= votingAccept || scrollView.contentOffset.x >= votingReject {
            UIView.animateWithDuration(0.8, animations: {
                self.swipeRightGreenImage.layer.opacity = 0
                self.swipeLeftRedImage.layer.opacity = 0
            })
        }
    }

}
