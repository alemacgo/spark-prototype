//
//  FeedViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/17/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

let LisbonCenter = CGPoint(x: 1141.5, y: 446.0)
let todayFeed = UIImage(named: "todayfeed")
let yesterdayFeed = UIImage(named: "yesterdayfeed")

class TodayFeedViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    var feedStrip: UIImageView!
    var photoTaken: UIImage?
    var photoView: UIImageView!
    @IBOutlet weak var mapView: UIScrollView!
    var feedViewDelegate: FeedViewDelegate!
    @IBOutlet weak var selectedMode: UIImageView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320, 2255+325+121)
        containerView = UIView(frame: CGRect(origin: CGPointMake(0, 0), size:containerSize))
        scrollView.addSubview(containerView)
        
        photoView = UIImageView(frame: CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(320, 320)))
        containerView.addSubview(photoView)
        
        feedStrip = UIImageView(image: todayFeed)
        feedStrip.frame = CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(320, 2255))
        containerView.addSubview(feedStrip)

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

        // Do any additional setup after loading the view.
        mapView.delegate = self
        feedViewDelegate = FeedViewDelegate(mapView: mapView)
        scrollView.delegate = feedViewDelegate
        mapView.contentSize = mapView.subviews[0].size!
        mapView.contentOffset = LisbonCenter
    }
    
    override func viewDidAppear(animated: Bool) {
        if let photoTaken = photoTaken {
            photoView.image = photoTaken
            move({self.feedStrip.center.y += 325})
        }
    }

    @IBAction func didTapOnDice(sender: UIButton) {
        move({self.selectedMode.center.x = 101})
        move({self.scrollView.center.y = 405}, {self.mapView.hidden = true; self.sliderView.hidden = true})
    }
    
    @IBAction func didTapOnWorld(sender: UIButton) {
        move({self.selectedMode.center.x = 161})
        mapView.hidden = false
        sliderView.hidden = true
        move({self.scrollView.center.y = 655})
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
        if (willFocusOnWest) {
            feedStrip.image = yesterdayFeed
        }
        else {
            feedStrip.image = todayFeed
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
    
    @IBAction func didTapOnClock(sender: UIButton) {
        move({self.selectedMode.center.x = 221})
        sliderView.hidden = false
        mapView.hidden = true
        move({self.scrollView.center.y = 655})
        hourLabel.hidden = false
    }
    
    @IBAction func didMoveSlider(sender: UISlider) {
        // Updating the view here makes the photo feed slide back up
        hourLabel.text = valueToHour(sender.value)
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
