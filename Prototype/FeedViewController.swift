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
    case Original = 352.5
    case Low = 534.5 // Original + mapView.frame.size.height
}

let LisbonCenter = CGPoint(x: 1141.5, y: 446)

let clockAscending = UIImage(named: "ascending")
let clockDescending = UIImage(named: "descending")

let smellAscending = UIImage(named: "smellAscending")
let smellDescending = UIImage(named: "smellDescending")
let smellEast = UIImage(named: "smellEast")
let smellWest = UIImage(named: "smellWest")

class FeedViewController: UIViewController, UIScrollViewDelegate {
  
    var displayMode: DisplayMode!
    var challenge: Challenge!
    
    @IBOutlet weak var feedView: UIScrollView!
    @IBOutlet weak var mapView: UIScrollView!
    
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var selectedModeBar: UIImageView!
    
    override func viewDidLoad() {
        feedView.contentSize = feedView.subviews[0].size!
        mapView.contentSize = mapView.subviews[0].size!
        mapView.contentOffset = LisbonCenter

        challenge = .Smell
        displayMode = .Descending
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
                feedImage.image = smellEast
            }
        }
        feedView.contentOffset.y = 0 // Bring the feed to the top image
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

}