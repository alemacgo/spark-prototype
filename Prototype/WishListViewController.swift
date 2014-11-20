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
let middle: CGFloat = 320

enum Vote {
    case Yes
    case No
    case Neutral
}

class WishListViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var swipeButton: UIScrollView!
    @IBOutlet weak var swipeButton2: UIScrollView!
    @IBOutlet weak var swipeButton3: UIScrollView!
    @IBOutlet weak var swipeButton4: UIScrollView!
    
    @IBOutlet weak var voteNoImage1: UIImageView!
    @IBOutlet weak var voteYesImage1: UIImageView!
    @IBOutlet weak var voteNoImage2: UIImageView!
    @IBOutlet weak var voteYesImage2: UIImageView!
    
    var vote: Vote!
    
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
        
        vote = .Neutral
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTouchSwipeButton(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended {
            // end wobble
        }
        else {
            // wobble
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scroll = scrollView.contentOffset.x
        println("didScroll \(scroll)")

        if scroll < middle {
            voteYesImage1.hidden = false
            voteNoImage1.hidden = true
        }
        else if scroll > middle {
            voteYesImage1.hidden = true
            voteNoImage1.hidden = false
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scroll = scrollView.contentOffset.x
        println("dragging \(scroll)")
        if scroll >= votingReject {
            vote = .No
        }
        else if scroll <= votingAccept {
            println("e")
            vote = .Yes
        }
        else {
            vote = .Neutral
        }
        if vote == .Yes {
            UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                    self.voteYesImage1.center.x = 640
                }, completion: {_ in
                    //self.voteYesImage1.hidden = true
                    //self.voteYesImage1.center.x = 160.5
                })
        }
        else if vote == .No {
            UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                    self.voteNoImage1.center.x = -320
                }, completion: {_ in
                    //self.voteNoImage1.hidden = true
                    //self.voteNoImage1.center.x = 160.5
            })
        }
        vote = .Neutral
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {

        //move centers
    }

}
