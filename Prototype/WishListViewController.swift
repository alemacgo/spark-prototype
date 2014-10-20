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

class WishListViewController: UIViewController {
    var originViewController = OriginViewControllers.Today
    let verticalManager = VerticalTransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
