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

let clockAscending = UIImage(named: "ascending")
let clockDescending = UIImage(named: "descending")

class FeedViewController: UIViewController {
  
    @IBOutlet weak var feedView: UIScrollView!
    var displayMode: DisplayMode!
    @IBOutlet weak var clockIcon: UIImageView!
    
    override func viewDidLoad() {
        feedView.contentSize = feedView.subviews[0].size!
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
    
    func updateFeed() {
        if displayMode == .Descending {
            clockIcon.image = clockDescending
        }
        else if displayMode == .Ascending {
            clockIcon.image = clockAscending
        }
    }

}