//
//  FeedViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/17/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

let LisbonCenter = CGPoint(x: 1141.5, y: 446.0)
let randomFeed = UIImage(named: "randomfeed")

let mapFeedEast = UIImage(named: "mapfeedeast")
let mapFeedWest = UIImage(named: "mapfeedwest")
let previousMapFeedEast = UIImage(named: "previousmapfeedeast")
let previousMapFeedWest = UIImage(named: "previousmapfeedwest")

let timeFeedBefore = UIImage(named: "timefeedbefore")
let timeFeedAfter = UIImage(named: "timefeedafter")
let previoustimeFeedBefore = UIImage(named: "previoustimefeedbefore")
let previoustimeFeedAfter = UIImage(named: "previoustimefeedafter")

enum Time {
    case Previous
    case Current
}

enum Mode {
    case Random
    case Map
    case Time
}

class TodayFeedViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    var feedStrip: UIImageView!
    var photoTaken: UIImage?
    var photoView: UIImageView!
    @IBOutlet weak var mapView: UIScrollView!
    var feedViewDelegate: FeedViewDelegate!
    @IBOutlet weak var selectedMode: UIImageView!
    @IBOutlet weak var timeView: UIScrollView!
    
    var feedOriginalCenter: CGFloat!
    var filterViewHeight: CGFloat!
    
    var time = Time.Current
    var mode = Mode.Random
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320, 1216+325)
        containerView = UIView(frame: CGRect(origin: CGPointMake(0, 0), size:containerSize))
        scrollView.addSubview(containerView)
        
        photoView = UIImageView(frame: CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(320, 320)))
        containerView.addSubview(photoView)
        
        feedStrip = UIImageView(image: randomFeed)
        feedStrip.frame = CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(320, 1216))
        containerView.addSubview(feedStrip)

        scrollView.contentSize = containerSize;

        // Do any additional setup after loading the view.
        mapView.delegate = self
        feedViewDelegate = FeedViewDelegate(mapView: mapView, originalCenter:scrollView.center.y)
        scrollView.delegate = feedViewDelegate
        mapView.contentSize = mapView.subviews[0].size!
        mapView.contentOffset = LisbonCenter
        
        timeView.contentSize = timeView.subviews[0].size!
        
        feedOriginalCenter = scrollView.center.y
        filterViewHeight = mapView.frame.size.height
        
        updateFeed()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let photoTaken = photoTaken {
            photoView.image = photoTaken
            move({self.feedStrip.center.y += 325})
        }
    }

    @IBAction func didTapOnDice(sender: UIButton) {
        mode = .Random
        updateFeed()
    }
    
    @IBAction func didTapOnWorld(sender: UIButton) {
        mode = .Map
        updateFeed()
    }
    
    @IBAction func didTapOnClock(sender: UIButton) {
        mode = .Time
        updateFeed()
    }
   
    var willFocusOnWest = false
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if targetContentOffset.memory.x < 700 {
            willFocusOnWest = true
        }
        else {
            willFocusOnWest = false
        }
    }
    
    func updateFeed() {
        switch (mode) {
            case .Random:
                feedStrip.image = randomFeed
                move({self.selectedMode.center.x = 108})
                move({self.scrollView.center.y = self.feedOriginalCenter},
                    {self.mapView.hidden = true; self.timeView.hidden = true})
            case .Map:
                if (willFocusOnWest) {
                    feedStrip.image = mapFeedWest
                }
                else {
                    feedStrip.image = mapFeedEast
                }
                move({self.selectedMode.center.x = 161})
                mapView.hidden = false
                timeView.hidden = true
                move({self.scrollView.center.y = self.feedOriginalCenter + self.filterViewHeight})
            default:    // case .Time:
                timeView.hidden = false
                mapView.hidden = true
                move({self.selectedMode.center.x = 212})
                move({self.scrollView.center.y = self.feedOriginalCenter + self.filterViewHeight})
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updateFeed()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updateFeed()
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
    
    @IBAction func didTapOnFeed(sender: UILongPressGestureRecognizer) {
        move({self.scrollView.center.y = self.feedOriginalCenter},
            {self.mapView.hidden = true; self.timeView.hidden = true})
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
