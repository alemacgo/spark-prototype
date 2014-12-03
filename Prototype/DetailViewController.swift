//
//  DetailViewController.swift
//  Prototype
//
//  Created by Alejandro on 12/3/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    var detailImage: UIImage!
    
    override func viewWillAppear(animated: Bool) {
        detailImageView.image = detailImage
    }
}
