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

    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320, 5680)
        containerView = UIView(frame: CGRect(origin: CGPointMake(0, 0), size:containerSize))
        containerView.backgroundColor = UIColor.redColor()
        scrollView.addSubview(containerView)
        
        let imageView = UIImageView(image: UIImage(named: "today"))
        imageView.center = CGPoint(x:160, y:284);
        imageView.center.y += 568/2
        containerView.addSubview(imageView)
        
        // Tell the scroll view the size of the contents
        scrollView.contentSize = containerSize;
        
        // Set up the minimum & maximum zoom scale
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0

        
        
    }
    
    @IBAction func unwindTodayFromWishList(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromYesterday(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromUser(sender: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        if segue.identifier! == "todayToWishList" {
            toViewController.transitioningDelegate = self.verticalManager
            let wishListViewController = toViewController as WishListViewController
            wishListViewController.originViewController = .Today
        }
        else if segue.identifier! == "todayToYesterday" {
            toViewController.transitioningDelegate = self.horizontalManager
        }

    }
}

