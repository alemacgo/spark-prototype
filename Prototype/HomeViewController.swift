//
//  HomeViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/28/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit
import MobileCoreServices

enum Mode {
    case Random
    case Map
    case Time
}

class HomeViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pageView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var containerView: UIView!
    var placeholder: UIImageView!
    var photoView: UIImageView!
    var photoLabel: UIImageView!
    var feedStrip: UIImageView!
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var tabBar: UIImageView!
    var mode = Mode.Random
    var initialContentOffset = CGPointMake(0, 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.contentSize = pageView.subviews[0].size!
        println(pageView.contentSize)
        pageView.setContentOffset(CGPointMake(1280, 568), animated: false)
        println(pageView.contentOffset)
        
        picker.delegate = self
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320, 2432+350)
        containerView = UIView(frame: CGRect(origin: CGPointMake(0, 0), size:containerSize))
        scrollView.addSubview(containerView)
        
        placeholder = UIImageView(image: loadingImage)
        placeholder.layer.opacity = 0
        containerView.addSubview(placeholder)
        
        let photoSize = CGSizeMake(320, 320)
        photoView = UIImageView(frame: CGRect(origin: CGPointMake(0, 0), size: photoSize))
        containerView.addSubview(photoView)
        photoView.layer.opacity = 0
        
        photoLabel = UIImageView(image: photoLabelImage)
        photoLabel.center.y = 269+26
        containerView.addSubview(photoLabel)
        photoLabel.layer.opacity = 0
        
        scrollView.contentSize.height = containerSize.height
        
        feedStrip = UIImageView(image: randomFeed)
        feedStrip.frame = CGRect(origin: CGPointMake(0, 320), size: CGSizeMake(320, 2432))
        containerView.addSubview(feedStrip)
    }
    
    // Taking photos
    let picker = UIImagePickerController()
    @IBOutlet weak var cameraButton: UIButton!
    
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
            
            println("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
            
            if let type:AnyObject = mediaType{
                
                if type is String{
                    let stringType = type as String
                    
                    if stringType == kUTTypeImage as NSString {
                        
                        var theImage: UIImage!
                        
                        if picker.allowsEditing{
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
                        cameraButton.hidden = true
                        cameraImage.hidden = true
                    }
                }
            }
            
            picker.dismissViewControllerAnimated(false, {completed in
                self.mode = .Random
                self.showFeed()})
    }

    func showFeed() {
        move({self.scrollView.hidden = false; self.tabBar.center.y = 50; self.scrollView.center.y = 310})
        self.cameraImage.hidden = true
        self.cameraButton.hidden = true
        
        /*if (self.photoView.image != nil) {
            UIView.animateWithDuration(1, animations: {
                self.placeholder.layer.opacity = 1
                }, completion: {completed in
                    UIView.animateWithDuration(1, delay: 0.5, options: nil, animations: {
                        self.photoView.layer.opacity = 1
                        self.photoLabel.layer.opacity = 1
                        },
                        nil)
            })
        }*/
    }
    
    @IBAction func hideFeed(sender: UILongPressGestureRecognizer) {
        move({self.tabBar.center.y = 544; self.scrollView.center.y = 804}, {self.scrollView.hidden = true})
        if scrollView.contentOffset.x == 320 {
            self.cameraImage.hidden = false
            self.cameraButton.hidden = false
        }
    }
    
    @IBAction func didTapOnDice(sender: UIButton) {
        mode = .Random
        showFeed()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didTapCameraButton(sender: UIButton) {
        picker.sourceType = .Camera
        
        var f = picker.view.bounds
        f.size.height -= picker.navigationBar.bounds.size.height
        let barHeight = f.size.height/2 - f.size.width/2
        UIGraphicsBeginImageContext(f.size)
        //UIColor.blackColor().colorWithAlphaComponent(0.5).set()
        UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal);
        UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, 0.75*barHeight), kCGBlendModeNormal);
        let overlayImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        let overlayIV = UIImageView(frame: f)
        overlayIV.image = overlayImage;
        //overlayIV.userInteractionEnabled = false
        picker.cameraOverlayView?.userInteractionEnabled = false
        picker.cameraOverlayView?.addSubview(overlayIV)
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            pageControl.currentPage = 0
            cameraButton.hidden = true
            cameraImage.hidden = true
        }
        else if scrollView.contentOffset.x == 320 {
            pageControl.currentPage = 1
            if (photoView.image == nil) {
                cameraImage.hidden = true
                cameraButton.hidden = true
            }
            cameraButton.hidden = false
            cameraImage.hidden = false
            UIView.animateWithDuration(0.5, animations: {
                self.cameraImage.layer.opacity = 1
            })
        }
        else if scrollView.contentOffset.x == 640 {
            pageControl.currentPage = 2
            cameraButton.hidden = true
            cameraImage.hidden = true
        }
        else if scrollView.contentOffset.x == 960 {
            pageControl.currentPage = 3
            cameraButton.hidden = true
            cameraImage.hidden = true
        }
        else { // scrollView.contentOffset.x == 1280
            pageControl.currentPage = 4
            cameraButton.hidden = true
            cameraImage.hidden = true
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        initialContentOffset = scrollView.contentOffset
        
        UIView.animateWithDuration(0.2, animations: {
            self.cameraImage.layer.opacity = 0
        })
    }
    
    func move(action: () -> Void, completion: () -> Void = {}) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: nil, animations: {
            action()
            },
            completion: {completed in
                completion()
        })
    }

}
