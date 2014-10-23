//
//  ProfileViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/23/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

let badgesImage = UIImage(named: "badges")
let logImage = UIImage(named: "profileLog")

class ProfileViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = scrollView.subviews[0].size!
        scrollView.contentOffset.y = 140
    }
    
    @IBAction func didTapTrophy(sender: UIButton) {
        (scrollView.subviews[0] as UIImageView).image = badgesImage
        scrollView.contentOffset.y = 0
    }
    
    @IBAction func didTapBook(sender: UIButton) {
        (scrollView.subviews[0] as UIImageView).image = logImage
        scrollView.contentOffset.y = 140
    }
}
