//
//  YesterdayViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class YesterdayViewController: UIViewController {
    let verticalManager = VerticalTransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindYesterdayFromWishList(sender: UIStoryboardSegue) {
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        if segue.identifier! == "yesterdayToWishList" {
            toViewController.transitioningDelegate = self.verticalManager
            let wishListViewController = toViewController as WishListViewController
            wishListViewController.originViewController = .Yesterday
        }
    }
}
