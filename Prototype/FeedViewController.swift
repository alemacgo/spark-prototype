//
//  FeedViewController.swift
//  Prototype
//
//  Created by Alejandro on 11/11/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
  
    @IBOutlet weak var feedView: UIScrollView!
    
    override func viewDidLoad() {
        feedView.contentSize = feedView.subviews[0].size!
    }

}