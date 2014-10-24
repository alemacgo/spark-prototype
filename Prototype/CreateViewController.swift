//
//  CreateViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/24/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    @IBOutlet weak var badgePopup: UIView!

    @IBAction func didTapCancel(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: {
            self.badgePopup.layer.opacity = 0
            }, completion: {completed in
                self.badgePopup.hidden = true
        })
    }
    @IBAction func didTapDiamond(sender: UIButton) {
        
        badgePopup.hidden = false
        UIView.animateWithDuration(0.5, animations: {
            self.badgePopup.layer.opacity = 1
        })
        
    }
    
    override func viewDidLoad() {
        badgePopup.hidden = true
        badgePopup.layer.opacity = 0
    }

}