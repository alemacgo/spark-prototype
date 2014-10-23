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

enum VotingOutcomes: CGFloat {
    case Reject = 640
    case Neutral = 320
    case Accept = 0
}

class WishListViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    var originViewController = OriginViewControllers.Today
    let verticalManager = VerticalTransitionManager()
    
    @IBOutlet weak var swipeRightImage: UIImageView!
    @IBOutlet weak var swipeRightGreenImage: UIImageView!
    @IBOutlet weak var swipeLeftImage: UIImageView!
    @IBOutlet weak var swipeButton: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeButton.contentSize = swipeButton.subviews[0].size!
        swipeButton.contentOffset.x = 320
        swipeRightImage.layer.opacity = 0
        swipeLeftImage.layer.opacity = 0
        swipeRightGreenImage.layer.opacity = 0
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTouchSwipeButton(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended {
            UIView.animateWithDuration(0.5, delay: 0.7, options: nil, animations: {
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
        println(scrollView.contentOffset)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if let vote = VotingOutcomes(rawValue: scrollView.contentOffset.x) {
            switch vote {
                case .Accept:
                    UIView.animateWithDuration(1.0, animations: {
                            println("e")
                            self.swipeRightGreenImage.layer.opacity = 1
                        }, completion: {completed in
                            UIView.animateWithDuration(0.5, animations: {
                                self.swipeRightGreenImage.layer.opacity = 0
                            })
                        }
                )
                case .Reject:
                    println("reject")
                default:
                    break
            }
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
