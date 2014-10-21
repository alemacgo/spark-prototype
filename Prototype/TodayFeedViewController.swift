//
//  FeedViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/17/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class TodayFeedViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var containerView: UIView!
    var feedStrip: UIImageView!
    var photoTaken: UIImage?
    var photoView: UIImageView!
    @IBOutlet weak var mapView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320, 2255+325+121)
        containerView = UIView(frame: CGRect(origin: CGPointMake(0, 0), size:containerSize))
        scrollView.addSubview(containerView)
        
        photoView = UIImageView(frame: CGRect(origin: CGPointMake(0, 0), size: CGSizeMake(320, 320)))
        containerView.addSubview(photoView)
        
        feedStrip = UIImageView(image: UIImage(named: "todayfeed"))
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
        mapView.contentSize = mapView.subviews[0].size!
    }
    
    override func viewDidAppear(animated: Bool) {
        if let photoTaken = photoTaken {
            photoView.image = photoTaken
            //photoView.contentMode ?
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.feedStrip.center.y += 325
            }, nil)
        }
    }
    
    @IBAction func didTapOnWorld(sender: UIButton) {
        if scrollView.center.y >= 655 {
            return
        }
        /*
        let map = UIView(frame: CGRectMake(0, 121, 320, 250))
        map.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.view.addSubview(map)*/
        mapView.hidden = false
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
            self.scrollView.center.y += 250
            }, nil)
    }

    @IBAction func didTapOnDice(sender: UIButton) {
        if scrollView.center.y <= 405 {
            return
        }
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil,
            animations: {
                self.scrollView.center.y -= 250
            },
            completion: {completed in
                self.mapView.hidden = true
            })
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
