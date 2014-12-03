//
//  MasterViewController.swift
//  Prototype
//
//  Created by Alejandro on 11/7/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit
import MobileCoreServices

class MasterViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var pageView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var logView: UIScrollView!
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    let verticalManager = VerticalTransitionManager()
    let reverseVerticalManager = ReverseVerticalTransitionManager()
    
    var challenge: Challenge!
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var placeLabel: UIImageView!
    
    var detailImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.contentSize = CGSizeMake(320*6, 568)
        pageView.contentOffset = CGPointMake(1920, 0)
        pageView.contentInset = UIEdgeInsetsMake(0, -320, 0, 320)
        
        photoView.layer.opacity = 0
        placeLabel.layer.opacity = 0
        
        logView.contentSize = logView.subviews[0].size!
        
        challenge = .Smell
        
        picker.delegate = self
    }

    // MARK: Page-specific code
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.5) {
            self.pageControl.center.y = 494.5
        }
        if (scrollView.contentOffset.x >= 640) {
            UIView.animateWithDuration(0.3, delay: 0.2, options: nil, animations: {
                self.starButton.layer.opacity = 1
                self.downButton.layer.opacity = 1
                }, completion: nil)
        }
        
        switch (scrollView.contentOffset.x) {
            case 320:
                pageControl.currentPage = 0
                UIView.animateWithDuration(0.5) {
                    self.starButton.layer.opacity = 0
                    self.downButton.layer.opacity = 0
                    self.pageControl.center.y = 525
                }
            case 640:
                pageControl.currentPage = 1
                challenge = .Looks
            case 960:
                pageControl.currentPage = 2
                challenge = .Napkin
            case 1280:
                pageControl.currentPage = 3
                challenge = .Smile
            case 1600:
                pageControl.currentPage = 4
                challenge = .Green
            case 1920:
                pageControl.currentPage = 5
                challenge = .Smell
            default:
                break
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x < 640 {
            UIView.animateWithDuration(0.5) {
                self.starButton.layer.opacity = 0
                self.downButton.layer.opacity = 0
                self.pageControl.center.y = 525
            }
        }
    }
    
    @IBAction func didTapCurrentButton(sender: UIButton) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: nil, animations: {
                self.pageView.contentOffset.x = 1920
            }, completion: {_ in
                self.scrollViewDidEndDecelerating(self.pageView)})
    }
    
    // MARK: Log expansion
    @IBAction func didTapLogElement(sender: UIButton) {
        switch (sender.tag) {
            case 0:
                detailImage = UIImage(named: "logImage1")
            case 1:
                detailImage = UIImage(named: "logImage2")
            case 2:
                detailImage = UIImage(named: "logImage3")
            default: // case 3
                detailImage = UIImage(named: "logImage4")
        }
        performSegueWithIdentifier("masterToDetail", sender: self)
    }
    
    // MARK: Camera functionality
    let picker = UIImagePickerController()
    
    @IBAction func didTapCameraButton(sender: UIButton) {
            picker.sourceType = .Camera
            
            var f = picker.view.bounds
            f.size.height -= picker.navigationBar.bounds.size.height
            let barHeight = f.size.height/2 - f.size.width/2
            UIGraphicsBeginImageContext(f.size)
            UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal);
            UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, 0.75*barHeight), kCGBlendModeNormal);
            let overlayImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            let overlayIV = UIImageView(frame: f)
            overlayIV.image = overlayImage;
            picker.cameraOverlayView?.userInteractionEnabled = false
            picker.cameraOverlayView?.addSubview(overlayIV)
            
            self.presentViewController(picker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
            
            println("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
            
            if let type:AnyObject = mediaType {
                if type is String {
                    let stringType = type as String
                    
                    if stringType == kUTTypeImage as NSString {
                        
                        var theImage: UIImage!
                        
                        if picker.allowsEditing {
                            theImage = info[UIImagePickerControllerEditedImage] as UIImage
                        } else {
                            theImage = info[UIImagePickerControllerOriginalImage] as UIImage
                        }
                        
                        let width = theImage.size.width
                        let height = theImage.size.height
                        if (height != width) {
                            var newDimension = min(width, height);
                            var widthOffset = (width - newDimension) / 2;
                            let heightOffset = (height - newDimension) / 2;
                            UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), false, 0.0);
                            theImage.drawAtPoint(CGPointMake(-widthOffset, -heightOffset),
                                blendMode:kCGBlendModeCopy,
                                alpha:1.0)
                            theImage = UIGraphicsGetImageFromCurrentImageContext();
                            UIGraphicsEndImageContext();
                        }
                        
                        photoView.image = theImage
                        cameraImage.hidden = true
                    }
                }
            }
            
            picker.dismissViewControllerAnimated(false, completion: {
                self.photoView.layer.opacity = 0
                self.placeLabel.layer.opacity = 0
                UIView.animateWithDuration(1) {
                    self.photoView.layer.opacity = 1
                    self.placeLabel.layer.opacity = 1
                }
            })
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    @IBAction func unwindMasterFromDetail(sender: UIStoryboardSegue) {
        
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
            var feedViewController = segue.destinationViewController as FeedViewController
            feedViewController.challenge = challenge
        }
        if segue.identifier == "masterToDetail" {
            var detailViewController = segue.destinationViewController as DetailViewController
            detailViewController.detailImage = detailImage!
        }
    }
}