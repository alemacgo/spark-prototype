//
//  FeedViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/17/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit
var i = 0
class ContainerView : UIScrollView {
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.panGestureRecognizer
        println("touched \(i)")
        i++
        println(nextResponder())
        //nextResponder()?.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        //nextResponder()?.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesCancelled(touches: NSSet, withEvent event: UIEvent) {
        //nextResponder()?.touchesBegan(touches, withEvent: event)
    }

}

class FeedViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var scrollView: ContainerView!
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

}
