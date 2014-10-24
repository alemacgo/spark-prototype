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
    let timeView: UIScrollView
    let triangleView: UIView
    let originalCenter: CGFloat
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if scrollView.center.y != originalCenter {
            UIView.animateWithDuration(0.5, animations: {
                self.mapView.layer.opacity = 0
                self.timeView.layer.opacity = 0
            })
            UIView.animateWithDuration(1.0, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8, options: nil,
                animations: {
                    scrollView.center.y -= self.mapView.frame.size.height
                    self.triangleView.layer.opacity = 0
                }, nil)
        }
    }
    
    init(mapView: UIScrollView, timeView: UIScrollView, triangleView: UIView, originalCenter: CGFloat) {
        self.mapView = mapView
        self.timeView = timeView
        self.triangleView = triangleView
        self.originalCenter = originalCenter
        super.init()
    }
}
