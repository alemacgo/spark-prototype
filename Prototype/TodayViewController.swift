//
//  ViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UIScrollViewDelegate {
    let horizontalManager = HorizontalTransitionManager()
    let verticalManager = VerticalTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindTodayFromWishList(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromYesterday(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromUser(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromFeed(sender: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        if let identifier = SegueIdentifier(rawValue: segue.identifier!) {
            switch identifier {
                case .TodayToWishList:
                    toViewController.transitioningDelegate = self.verticalManager
                    let wishListViewController = toViewController as WishListViewController
                    wishListViewController.originViewController = .Today
                case SegueIdentifier.TodayToYesterday:
                    toViewController.transitioningDelegate = self.horizontalManager
            }
        }
    }
}

