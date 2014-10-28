//
//  HomeViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/28/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit
import MobileCoreServices

class HomeViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var pageView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topBar: UIImageView!
    
    var containerView: UIView!
    var placeholder: UIImageView!
    var photoView: UIImageView!
    var photoLabel: UIImageView!
    var feedStrip: UIImageView!

    override func viewDidLoad() {
        pageView.contentSize = scrollView.subviews[0].size!
        pageView.contentOffset.x = 320
        
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
        
        scrollView.contentOffset = CGPointMake(0, 0)
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
                    }
                }
            }
            
            picker.dismissViewControllerAnimated(false, {completed in
                // = .Random
                self.showFeed()})
    }

    func showFeed() {
        scrollView.hidden = false
        self.topBar.hidden = false
        if (self.photoView.image != nil) {
            UIView.animateWithDuration(1, animations: {
                self.placeholder.layer.opacity = 1
                }, completion: {completed in
                    UIView.animateWithDuration(1, delay: 0.5, options: nil, animations: {
                        self.photoView.layer.opacity = 1
                        self.photoLabel.layer.opacity = 1
                        },
                        nil)
            })
        }
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
        }
        else if scrollView.contentOffset.x == 320 {
            pageControl.currentPage = 1
        }
        else { // scrollView.contentOffset.x == 0
            pageControl.currentPage = 2
        }
    }

}
