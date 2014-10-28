//
//  HomeViewController.swift
//  Prototype
//
//  Created by Alejandro on 10/28/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        scrollView.contentSize = scrollView.subviews[0].size!
        scrollView.contentOffset.x = 320
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 {
            pageControl.currentPage = 0
        }
        else if scrollView.contentOffset.x == 320 {
            pageControl.currentPage = 1
        }
        else { // scrollView.contentOffset.x == 0
            pageControl.currentPage = 2
        }
    }

}
