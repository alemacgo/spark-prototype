//
//  FeedViewDelegate.swift
//  Prototype
//
//  Created by Alejandro on 10/22/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

class FeedViewDelegate: NSObject, UIScrollViewDelegate {
    
    let mapView: UIScrollView
    let originalCenter: CGFloat
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.center.y != originalCenter {
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil,
                animations: {
                    scrollView.center.y -= self.mapView.frame.size.height
                },
                completion: {completed in
                    self.mapView.hidden = true
            })
        }
    }
    
    init(mapView: UIScrollView, originalCenter: CGFloat) {
        self.mapView = mapView
        self.originalCenter = originalCenter
        super.init()
    }
}
