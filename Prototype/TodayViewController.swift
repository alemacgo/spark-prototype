//
//  ViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit
import MobileCoreServices

let todayPhoto = UIImage(named: "todayphoto")
let randomFeed = UIImage(named: "randomfeed")
let loadingImage = UIImage(named: "loading")
let photoLabelImage = UIImage(named: "stockholmLabel")

class TodayViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    let horizontalManager = HorizontalTransitionManager()
    let verticalManager = VerticalTransitionManager()
    
    var photoView: UIImageView!
    var placeholder: UIImageView!
    var photoLabel: UIImageView!
    
    var lastContentOffset: CGFloat = 0
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var challengeTitle: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var containerView: UIView!
    var feedStrip: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        // Set up the container view to hold your custom view hierarchy
        let containerSize = CGSizeMake(320, 1555)
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
        feedStrip.frame = CGRect(origin: CGPointMake(0, 320), size: CGSizeMake(320, 1230))
        containerView.addSubview(feedStrip)
        
        scrollView.contentOffset = CGPointMake(0, 0)
    }
    
    // Taking photos
    let picker = UIImagePickerController()
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        if self.photoView.image != nil {
            background.image = todayPhoto
            challengeTitle.hidden = true
            scrollView.hidden = false
            UIView.animateWithDuration(1, animations: {
                self.placeholder.layer.opacity = 1
                }, completion: {completed in
                    UIView.animateWithDuration(1, delay: 0.5, options: nil, animations: {
                        self.photoView.layer.opacity = 1
                        self.photoLabel.layer.opacity = 1
                        },
                        nil)})
        }
    }
    
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
            })
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
    
    // Segues
    @IBAction func unwindTodayFromWishList(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromYesterday(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromUser(sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindTodayFromFeed(sender: UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        if let identifier = SegueIdentifier(rawValue: segue.identifier!) {
            switch identifier {
                case .TodayToWishList:
                    toViewController.transitioningDelegate = self.verticalManager
                    let wishListViewController = toViewController as WishListViewController
                    wishListViewController.originViewController = .Today
                default: // SegueIdentifier.TodayToProfile:
                    toViewController.transitioningDelegate = self.horizontalManager
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            println("arriba")
        }
        else {
            println("abajo")
        }
        lastContentOffset = scrollView.contentOffset.y
    }
}

