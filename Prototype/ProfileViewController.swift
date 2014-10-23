//
//  ProfileViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/23/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = scrollView.subviews[0].size!
    }
}