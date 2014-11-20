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

let wish1Green = UIImage(named: "wish1green")

class WishListViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var swipeButton0: UIScrollView!
    @IBOutlet weak var swipeButton1: UIScrollView!
    @IBOutlet weak var swipeButton2: UIScrollView!
    @IBOutlet weak var swipeButton3: UIScrollView!
    
    @IBOutlet weak var voteNoImage0: UIImageView!
    @IBOutlet weak var voteYesImage0: UIImageView!
    @IBOutlet weak var voteNoImage1: UIImageView!
    @IBOutlet weak var voteYesImage1: UIImageView!
    @IBOutlet weak var voteNoImage2: UIImageView!
    @IBOutlet weak var voteYesImage2: UIImageView!
    @IBOutlet weak var voteNoImage3: UIImageView!
    @IBOutlet weak var voteYesImage3: UIImageView!
    
    var voteNoImages: [UIImageView]!
    var voteYesImages: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeButton0.contentSize = swipeButton0.subviews[0].size!
        swipeButton0.contentOffset.x = 320
        swipeButton1.contentSize = swipeButton2.subviews[0].size!
        swipeButton1.contentOffset.x = 320
        swipeButton2.contentSize = swipeButton2.subviews[0].size!
        swipeButton2.contentOffset.x = 320
        swipeButton3.contentSize = swipeButton2.subviews[0].size!
        swipeButton3.contentOffset.x = 320
        
        swipeButton0.tag = 0
        swipeButton1.tag = 1
        swipeButton2.tag = 2
        swipeButton3.tag = 3
        
        voteNoImages = [voteNoImage0, voteNoImage1, voteNoImage2, voteNoImage3]
        voteYesImages = [voteYesImage0, voteYesImage1, voteYesImage2, voteYesImage3]
        
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

        if scroll < middle {
            voteYesImages[scrollView.tag].hidden = false
            voteNoImages[scrollView.tag].hidden = true
        }
        else if scroll > middle {
            voteYesImages[scrollView.tag].hidden = true
            voteNoImages[scrollView.tag].hidden = false
        }
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        acceptOrReject(scrollView, duration: 1.5)
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        acceptOrReject(scrollView, duration: 0.2)
    }
    
    func acceptOrReject(scrollView: UIScrollView, duration: NSTimeInterval) {
        let scroll = scrollView.contentOffset.x

        if scroll <= votingAccept {
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.voteYesImages[scrollView.tag].center.x = 640
                }, completion: {_ in
                    //self.voteYesImage1.hidden = true
                    //self.voteYesImage1.center.x = 160.5
            })
        }
        else if scroll >= votingReject {
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.voteNoImages[scrollView.tag].center.x = -320
                }, completion: {_ in
                    //self.voteNoImage1.hidden = true
                    //self.voteNoImage1.center.x = 160.5
            })
        }
    }

}
