//
//  FeedViewController.swift
//  Prototype
//
//  Created by Alejandro on 11/11/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit


enum DisplayMode {
    case Descending
    case Ascending
    case Map
}

enum Challenge {
    case Smell
    case Green
    case Smile
    case Napkin
    case Looks
}

enum Longitude {
    case East
    case West
}

class FeedViewController: UIViewController, UIScrollViewDelegate {
  
    var displayMode: DisplayMode!
    var challenge: Challenge!
    var longitude: Longitude!
    
    @IBOutlet weak var feedView: UIScrollView!
    @IBOutlet weak var mapView: UIScrollView!
    
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet weak var topBar: UIImageView!
    @IBOutlet weak var selectedModeBar: UIImageView!
    var clockAscending: UIImage!
    var clockDescending: UIImage!
    
    var photo: UIImage?
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var placeLabel: UIImageView!
    
    override func viewDidLoad() {
        feedView.contentSize = feedView.subviews[0].size!
        mapView.contentSize = mapView.subviews[0].size!
        mapView.contentOffset = LisbonCenter
        
        loadChallengeData()
        displayMode = .Descending
        longitude = .East
        updateFeed()
    }
    
    override func viewDidAppear(animated: Bool) {
        if photo != nil {
            updateFeed()
        }
    }
    
    @IBAction func didTapOnClock(sender: UIButton) {
        if (displayMode == .Descending) {
            displayMode = .Ascending
        }
        else {
            displayMode = .Descending
        }
        updateFeed()
    }
    
    @IBAction func didTapOnWorld(sender: UIButton) {
        displayMode = .Map
        updateFeed()
    }
    
    // MARK: Scroll View Custom Behaviors
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView == feedView {
            if scrollView.center.y != FeedCenter.Original.rawValue {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil,
                    animations: {
                        self.mapView.layer.opacity = 0
                        scrollView.center.y = FeedCenter.Original.rawValue
                    }, nil)
            }
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == mapView {
            if targetContentOffset.memory.x < 700 {
                longitude = .West
            }
            else {
                longitude = .East
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == mapView && !decelerate {
            updateFeed()
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView == mapView {
            updateFeed()
        }
    }
    
    // MARK: Challenge-specific code
    func loadChallengeData() {
        switch (challenge!) {
            case .Smell:
                topBar.image = smellTopBar
                selectedModeBar.image = smellSelectedBar
                clockAscending = smellClockAscending
                clockDescending = smellClockDescending
            case .Green:
                topBar.image = greenTopBar
                selectedModeBar.image = greenSelectedBar
                clockAscending = greenClockAscending
                clockDescending = greenClockDescending
            case .Smile:
                topBar.image = smileTopBar
                selectedModeBar.image = smileSelectedBar
                clockAscending = smileClockAscending
                clockDescending = smileClockDescending
            case .Napkin:
                topBar.image = napkinTopBar
                selectedModeBar.image = napkinSelectedBar
                clockAscending = napkinClockAscending
                clockDescending = napkinClockDescending
            default: // Looks
                topBar.image = looksTopBar
                selectedModeBar.image = looksSelectedBar
                clockAscending = looksClockAscending
                clockDescending = looksClockDescending
        }
    }
    
    func updateFeed() {
        feedImage.center.y = FeedImageCenter.Original.rawValue
        photoView.hidden = true
        placeLabel.hidden = true
        
        if displayMode == .Descending {
            clockIcon.image = clockDescending
            UIView.animateWithDuration(0.3) {
                self.selectedModeBar.center.x = BarX.Clock.rawValue
            }
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.mapView.layer.opacity = 0
                self.feedView.center.y = FeedCenter.Original.rawValue
                }, completion: nil)
        }
        else if displayMode == .Ascending {
            clockIcon.image = clockAscending
        }
        else { // Map mode
            UIView.animateWithDuration(0.3) {
                self.selectedModeBar.center.x = BarX.World.rawValue
            }
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.mapView.layer.opacity = 1
                self.feedView.center.y = FeedCenter.Low.rawValue
                }, completion: nil)
        }
        
        if challenge == .Smell {
            if displayMode == .Descending {
                feedImage.image = smellDescending
                if photo != nil {
                    feedImage.center.y = FeedImageCenter.Low.rawValue
                    photoView.image = photo
                    photoView.hidden = false
                    placeLabel.hidden = false
                }
            }
            else if displayMode == .Ascending {
                feedImage.image = smellAscending
            }
            else if displayMode == .Map {
                if longitude == .East {
                    feedImage.image = smellEast
                }
                else {
                    feedImage.image = smellWest
                }
            }
        }
        else if challenge == .Green {
            if displayMode == .Descending {
                feedImage.image = greenDescending
            }
            else if displayMode == .Ascending {
                feedImage.image = greenAscending
            }
            else if displayMode == .Map {
                if longitude == .East {
                    feedImage.image = greenEast
                }
                else {
                    feedImage.image = greenWest
                }
            }
        }
        else if challenge == .Smile {
            if displayMode == .Descending {
                feedImage.image = smileDescending
            }
            else if displayMode == .Ascending {
                feedImage.image = smileAscending
            }
            else if displayMode == .Map {
                if longitude == .East {
                    feedImage.image = smileEast
                }
                else {
                    feedImage.image = smileWest
                }
            }
        }
        else if challenge == .Napkin {
            if displayMode == .Descending {
                feedImage.image = napkinDescending
            }
            else if displayMode == .Ascending {
                feedImage.image = napkinAscending
            }
            else if displayMode == .Map {
                if longitude == .East {
                    feedImage.image = napkinEast
                }
                else {
                    feedImage.image = napkinWest
                }
            }
        }
        else { // challenge == .Looks {
            if displayMode == .Descending {
                feedImage.image = looksDescending
            }
            else if displayMode == .Ascending {
                feedImage.image = looksAscending
            }
            else if displayMode == .Map {
                if longitude == .East {
                    feedImage.image = looksEast
                }
                else {
                    feedImage.image = looksWest
                }
            }
        }
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
                self.feedView.contentOffset.y = 0 // Bring the feed to the top image
            }, completion: nil)
    }

}