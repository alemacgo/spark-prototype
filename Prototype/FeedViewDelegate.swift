//
//  FeedViewDelegate.swift
//  Prototype
//
//  Created by Alejandro on 10/22/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class FeedViewDelegate: NSObject, UIScrollViewDelegate {
    
    let mapView:UIScrollView
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.center.y != 405 {
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil,
                animations: {
                    scrollView.center.y -= 250
                },
                completion: {completed in
                    self.mapView.hidden = true
            })
        }
    }
    
    init(mapView: UIScrollView) {
        self.mapView = mapView
        super.init()
    }
}
