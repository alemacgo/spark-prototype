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

let clockAscending = UIImage(named: "ascending")
let clockDescending = UIImage(named: "descending")

let smellAscending = UIImage(named: "smellAscending")
let smellDescending = UIImage(named: "smellDescending")

class FeedViewController: UIViewController {
  
    var displayMode: DisplayMode!
    var challenge: Challenge!
    
    @IBOutlet weak var feedView: UIScrollView!
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var selectedModeBar: UIImageView!
    
    override func viewDidLoad() {
        feedView.contentSize = feedView.subviews[0].size!
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
        }
        else if displayMode == .Ascending {
            clockIcon.image = clockAscending
        }
        else { // Map mode
            UIView.animateWithDuration(0.3) {
                self.selectedModeBar.center.x = BarX.World.rawValue
            }
        }
        
        if challenge == .Smell {
            if displayMode == .Descending {
                feedImage.image = smellDescending
            }
            else if displayMode == .Ascending {
                feedImage.image = smellAscending
            }
        }
    }

}