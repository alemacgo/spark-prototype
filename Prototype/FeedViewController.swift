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
}

enum Longitude {
    case East
    case West
}

enum BarX: CGFloat {
    case Clock = 121
    case World = 192
}

enum FeedCenter: CGFloat {
    case Original = 355.5
    case Low = 537.5 // Original + mapView.frame.size.height
}

let LisbonCenter = CGPoint(x: 1141.5, y: 446)

let smellClockAscending = UIImage(named: "smellClockAscending")
let smellClockDescending = UIImage(named: "smellClockDescending")
let smellTopBar = UIImage(named: "smellTopBar")
let smellSelectedBar = UIImage(named: "smellSelectedBar")
let smellAscending = UIImage(named: "smellAscending")
let smellDescending = UIImage(named: "smellDescending")
let smellEast = UIImage(named: "smellEast")
let smellWest = UIImage(named: "smellWest")

let greenClockAscending = UIImage(named: "greenClockAscending")
let greenClockDescending = UIImage(named: "greenClockDescending")
let greenTopBar = UIImage(named: "greenTopBar")
let greenSelectedBar = UIImage(named: "greenSelectedBar")
let greenAscending = UIImage(named: "greenAscending")
let greenDescending = UIImage(named: "greenDescending")
let greenEast = UIImage(named: "greenEast")
let greenWest = UIImage(named: "greenWest")

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
    
    override func viewDidLoad() {
        feedView.contentSize = feedView.subviews[0].size!
        mapView.contentSize = mapView.subviews[0].size!
        mapView.contentOffset = LisbonCenter

        switch (challenge!) {
            case .Smell:
                topBar.image = smellTopBar
                selectedModeBar.image = smellSelectedBar
                clockAscending = smellClockAscending
                clockDescending = smellClockDescending
            default: // Green
                topBar.image = greenTopBar
                selectedModeBar.image = greenSelectedBar
                clockAscending = greenClockAscending
                clockDescending = greenClockDescending
        }
        displayMode = .Descending
        longitude = .East
        updateFeed()
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
    
    func updateFeed() {
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
        
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil, animations: {
            self.feedView.contentOffset.y = 0 // Bring the feed to the top image
        }, completion: nil)
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

}