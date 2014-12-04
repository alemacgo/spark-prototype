//
//  InstructionsViewController.swift
//  Prototype
//
//  Created by Alejandro on 12/4/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSizeMake(320*3, 568)
    }
    
    
    @IBAction func advance1(sender: UIButton) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.9, options: nil, animations: {
                self.scrollView.contentOffset.x = 320
            }, completion: nil)
    }
    
    
    @IBAction func advance2(sender: UIButton) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.9, options: nil, animations: {
            self.scrollView.contentOffset.x = 640
            }, completion: nil)
    }

}
