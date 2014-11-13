//
//  MasterViewController.swift
//  Prototype
//
//  Created by Alejandro on 11/7/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    let verticalManager = VerticalTransitionManager()
    let reverseVerticalManager = ReverseVerticalTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.contentSize = pageView.subviews[0].size!
        pageView.contentOffset = CGPointMake(1600, 0)
    }

    // MARK: Page-specific code
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.5) {
            self.pageControl.center.y = 494.5
        }
        UIView.animateWithDuration(0.3, delay: 0.2, options: nil, animations: {
            self.starButton.layer.opacity = 1
            self.downButton.layer.opacity = 1
        }, completion: nil)
        
        switch (scrollView.contentOffset.x) {
            case 0:
                pageControl.currentPage = 0
                UIView.animateWithDuration(0.5) {
                    self.starButton.layer.opacity = 0
                    self.downButton.layer.opacity = 0
                    self.pageControl.center.y = 525
                }
            case 320:
                pageControl.currentPage = 1
            case 640:
                pageControl.currentPage = 2
            case 960:
                pageControl.currentPage = 3
            case 1280:
                pageControl.currentPage = 4
            case 1600:
                pageControl.currentPage = 5
            default:
                break
        }
    }
    
    // MARK: Camera functionality
    @IBAction func didTapCameraButton(sender: UIButton) {
        println("a")
    }
    
    // MARK: Animations
    func move(action: () -> Void, completion: () -> Void = {}) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: nil, animations: {
            action()
            },
            completion: {completed in
                completion()
        })
    }
    
    // MARK: Segues
    @IBAction func unwindMasterFromFuture(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindMasterFromFeed(sender: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        if segue.identifier! == "masterToFuture" {
            toViewController.transitioningDelegate = self.verticalManager
        }
        if segue.identifier! == "masterToFeed" {
            toViewController.transitioningDelegate = self.reverseVerticalManager
        }
    }
}