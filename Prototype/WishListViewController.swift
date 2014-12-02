//
//  WishListViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/16/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

let votingReject: CGFloat = 480
let votingAccept: CGFloat = 160
let middle: CGFloat = 320

let tagToWishY: [Int:CGFloat] = [0: 84, 1: 166, 2:249, 3: 332]

class WishListViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var swipeButton0: UIScrollView!
    @IBOutlet weak var swipeButton1: UIScrollView!
    @IBOutlet weak var swipeButton2: UIScrollView!
    @IBOutlet weak var swipeButton3: UIScrollView!
    
    @IBOutlet weak var voteNoImage0: UIImageView!
    @IBOutlet weak var voteYesImage0: UIImageView!
    @IBOutlet weak var voteNoImage1: UIImageView!
    @IBOutlet weak var voteYesImage1: UIImageView!
    @IBOutlet weak var voteNoImage2: UIImageView!
    @IBOutlet weak var voteYesImage2: UIImageView!
    @IBOutlet weak var voteNoImage3: UIImageView!
    @IBOutlet weak var voteYesImage3: UIImageView!
    
    @IBOutlet weak var wish1Green: UIImageView!
    @IBOutlet weak var wish1Red: UIImageView!
    @IBOutlet weak var wish2Green: UIImageView!
    @IBOutlet weak var wish2Red: UIImageView!
    @IBOutlet weak var wish3Green: UIImageView!
    @IBOutlet weak var wish3Red: UIImageView!
    @IBOutlet weak var wish4Green: UIImageView!
    @IBOutlet weak var wish4Red: UIImageView!
    
    var swipeButtons: [UIScrollView]!
    var voteNoImages: [UIImageView]!
    var voteYesImages: [UIImageView]!
    var greenImages: [UIImageView]!
    var redImages: [UIImageView]!
    
    let wishImage = UIImageView(image: UIImage(named: "wish5"))
    let wishImageGreen = UIImageView(image: UIImage(named: "wish5green"))
    let wishImageRed = UIImageView(image: UIImage(named: "wish5red"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeButtons = [swipeButton0, swipeButton1, swipeButton2, swipeButton3]
        for button in swipeButtons {
            button.contentSize = button.subviews[0].size!
            button.contentOffset.x = 320
        }
        
        swipeButton0.tag = 0
        swipeButton1.tag = 1
        swipeButton2.tag = 2
        swipeButton3.tag = 3
        
        voteNoImages = [voteNoImage0, voteNoImage1, voteNoImage2, voteNoImage3]
        voteYesImages = [voteYesImage0, voteYesImage1, voteYesImage2, voteYesImage3]
       
        greenImages = [wish1Green, wish2Green, wish3Green, wish4Green]
        redImages = [wish1Red, wish2Red, wish3Red, wish4Red]
        
        for image in greenImages {
            image.layer.opacity = 0
        }
        for image in redImages {
            image.layer.opacity = 0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        for image in voteNoImages {
            image.hidden = true
        }
        for image in voteYesImages {
            image.hidden = true
        }
    }
    
    @IBAction func didTouchSwipeButton(sender: UILongPressGestureRecognizer) {
        if sender.state == .Ended {
            // end wobble
        }
        else {
            // wobble
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scroll = scrollView.contentOffset.x

        if scroll < middle {
            voteYesImages[scrollView.tag].hidden = false
            voteNoImages[scrollView.tag].hidden = true
            UIView.animateWithDuration(0.3) {
                self.greenImages[scrollView.tag].layer.opacity = 1
                self.redImages[scrollView.tag].layer.opacity = 0
            }
        }
        else if scroll > middle {
            voteYesImages[scrollView.tag].hidden = true
            voteNoImages[scrollView.tag].hidden = false
            UIView.animateWithDuration(0.3) {
                self.redImages[scrollView.tag].layer.opacity = 1
                self.greenImages[scrollView.tag].layer.opacity = 0
            }
        }
        else {
            UIView.animateWithDuration(0.3) {
                self.greenImages?[scrollView.tag].layer.opacity = 0
                self.redImages?[scrollView.tag].layer.opacity = 0
            }
        }
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        acceptOrReject(scrollView, duration: 1.5)
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        acceptOrReject(scrollView, duration: 0.5)
    }
    
    var addedWish = false
    func addNextWish(tag: Int) {
        if (!addedWish) {
            swipeButtons[tag].hidden = true
            voteYesImages[tag].hidden = true
            voteNoImages[tag].hidden = true
            
            let y = tagToWishY[tag]!
            var wish = UIScrollView(frame: CGRectMake(0, y, 320, 75))

            wish.addSubview(wishImage)
            wish.addSubview(wishImageGreen)
            wish.addSubview(wishImageRed)

            wish.contentSize = wishImage.frame.size
            wish.contentOffset.x = 320
            wish.pagingEnabled = true
            wish.showsHorizontalScrollIndicator = false
            wish.showsVerticalScrollIndicator = false
            
            wish.tag = tag
            swipeButtons[tag] = wish
            wish.delegate = self
            
            greenImages[tag] = wishImageGreen
            redImages[tag] = wishImageRed
            
            wishImage.layer.opacity = 0
            wishImageRed.layer.opacity = 0
            wishImageGreen.layer.opacity = 0
            self.view.addSubview(wish)

            UIView.animateWithDuration(1, animations: {
                self.wishImage.layer.opacity = 1
                }, completion: {_ in
                    self.addedWish = true
            })
        }
    }
    
    func acceptOrReject(scrollView: UIScrollView, duration: NSTimeInterval) {
        let scroll = scrollView.contentOffset.x

        if scroll <= votingAccept {
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.voteYesImages[scrollView.tag].center.x = 640
                }, completion: {_ in
                    self.addNextWish(scrollView.tag)
            })
        }
        else if scroll >= votingReject {
            UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.voteNoImages[scrollView.tag].center.x = -320
                }, completion: {_ in
                    self.addNextWish(scrollView.tag)
            })
        }
    }
    
    @IBAction func unwindWishListFromCreate(sender: UIStoryboardSegue) {
        
    }

}
