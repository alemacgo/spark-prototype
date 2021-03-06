//
//  WishListViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

enum OriginViewControllers {
    case Yesterday
    case Today
}

let votingReject: CGFloat = 480
let votingAccept: CGFloat = 160

class WishListViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    var originViewController = OriginViewControllers.Today
    let verticalManager = VerticalTransitionManager()
    
    @IBOutlet weak var swipeRightImage: UIImageView!
    @IBOutlet weak var swipeRightGreenImage: UIImageView!
    @IBOutlet weak var swipeLeftImage: UIImageView!
    @IBOutlet weak var swipeLeftRedImage: UIImageView!
    
    @IBOutlet weak var swipeButton: UIScrollView!
    @IBOutlet weak var swipeButton2: UIScrollView!
    @IBOutlet weak var swipeButton3: UIScrollView!
    @IBOutlet weak var swipeButton4: UIScrollView!
    
    @IBOutlet weak var star0: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    
    var stars: [UIImageView]!
    
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
        
        star0.layer.opacity = 0
        star1.layer.opacity = 0
        star2.layer.opacity = 0
        star3.layer.opacity = 0
        star4.layer.opacity = 0
        stars = [star0, star1, star2, star3]
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
            UIView.animateWithDuration(0.5, animations: {
                self.stars[scrollView.tag].layer.opacity = 0
            })
        }
        else if vote <= votingAccept {
            swipeRightGreenImage.layer.opacity = 1
            swipeLeftRedImage.layer.opacity = 0
            UIView.animateWithDuration(0.5, animations: {
                self.stars[scrollView.tag].layer.opacity = 1
            })
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didSwipeUp(sender: UISwipeGestureRecognizer) {
        switch (originViewController) {
            case .Today:
                performSegueWithIdentifier("exitWishListToToday", sender: self)
            case .Yesterday:
                performSegueWithIdentifier("exitWishListToYesterday", sender: self)
            default:
                break
        }
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    @IBAction func didSwipeDown(sender: UISwipeGestureRecognizer) {
        performSegueWithIdentifier("wishListToCreate", sender: self)
    }
    
    @IBAction func unwindWishListFromCreate(sender: UIStoryboardSegue) {

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        if segue.identifier == "wishListToCreate" {
            toViewController.transitioningDelegate = self.verticalManager
        }
    }
}
