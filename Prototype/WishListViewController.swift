//
//  WishListViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

let votingReject: CGFloat = 400
let votingAccept: CGFloat = 240
let middle: CGFloat = 320

class WishListViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {    
    @IBOutlet weak var swipeRightImage: UIImageView!
    @IBOutlet weak var swipeRightGreenImage: UIImageView!
    @IBOutlet weak var swipeLeftImage: UIImageView!
    @IBOutlet weak var swipeLeftRedImage: UIImageView!
    
    @IBOutlet weak var swipeButton: UIScrollView!
    @IBOutlet weak var swipeButton2: UIScrollView!
    @IBOutlet weak var swipeButton3: UIScrollView!
    @IBOutlet weak var swipeButton4: UIScrollView!
    
    @IBOutlet weak var voteNo1: UIImageView!
    @IBOutlet weak var voteYes1: UIImageView!
    
    var votedYes = false
    var votedNo = false
    
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
        if vote < middle {
            voteYes1.hidden = false
            voteNo1.hidden = true
        }
        else if vote > middle {
            voteYes1.hidden = true
            voteNo1.hidden = false
        }
        if vote >= votingReject {
            println("NO")
            votedNo = true
            votedYes = false
        }
        else if vote <= votingAccept {
            println("YES")
            votedYes = true
            votedNo = false
        }
        else {
            println("NEUTRAL")
            votedYes = false
            votedNo = false
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        println("RELEASE")
        scrollView.userInteractionEnabled = false
        if votedYes {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                scrollView.contentOffset.x = 0
                }, completion: nil)
        }
        else if votedNo {
            UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                scrollView.contentOffset.x = 640
                }, completion: nil)
        }
        votedYes = false
        votedNo = false
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
