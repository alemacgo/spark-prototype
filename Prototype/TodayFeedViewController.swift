//
//  FeedViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/17/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

let randomFeed = UIImage(named: "randomfeed")

class TodayFeedViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    var feedStrip: UIImageView!
    
    @IBOutlet weak var feedBar: UIImageView!
    
    var feedOriginalCenter: CGFloat!
    var filterViewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320, 1555)
        containerView = UIView(frame: CGRect(origin: CGPointMake(0, 0), size:containerSize))
        scrollView.addSubview(containerView)
        
        scrollView.contentSize.height = containerSize.height
        
        feedStrip = UIImageView(image: randomFeed)
        feedStrip.frame = CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(320, 1230))
        containerView.addSubview(feedStrip)
        
        scrollView.contentOffset = CGPointMake(0, 119)
    }
   
    func move(action: () -> Void, completion: () -> Void = {}) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                action()
        },
            completion: {completed in
                completion()
        })
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    /*@IBAction func didTapOnFeed(sender: UILongPressGestureRecognizer) {
        move({self.scrollView.center.y = self.feedOriginalCenter},
            {self.mapView.hidden = true; self.timeView.hidden = true})
    }*/
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
