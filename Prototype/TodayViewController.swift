//
//  ViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit
import MobileCoreServices

class TodayViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let horizontalManager = HorizontalTransitionManager()
    let verticalManager = VerticalTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    // Taking photos
    var photoTaken: UIImage?
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
                        photoTaken = theImage
                        cameraButton.hidden = true
                    }
                }
            }
            
            picker.dismissViewControllerAnimated(false, completion: {
                self.performSegueWithIdentifier("todayToFeed", sender: self)
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
            case SegueIdentifier.TodayToProfile:
                toViewController.transitioningDelegate = self.horizontalManager
            case SegueIdentifier.TodayToFeed:
                if let photoTaken = photoTaken {
                    (toViewController as TodayFeedViewController).photoTaken = photoTaken
                }
            }
        }
    }
}

