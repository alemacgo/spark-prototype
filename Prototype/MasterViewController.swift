//
//  MasterViewController.swift
//  Prototype
//
//  Created by Alejandro on 11/7/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import UIKit

enum ScrollDirection {
    case None
    case Crazy
    case Right
    case Left
    case Up
    case Down
    case Horizontal
    case Vertical
}

class MasterViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageView: UIScrollView!
    var initialContentOffset: CGPoint!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    var canScrollHorizontally = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageView.contentSize = pageView.subviews[0].size!
        initialContentOffset = CGPointMake(1280, 568)
        pageView.setContentOffset(CGPointMake(1280, 568), animated: false)
    }
    
    // MARK: Scroll View - Determine direction
    
    func determineScrollDirection(scrollView: UIScrollView) -> ScrollDirection {
        var scrollDirection: ScrollDirection
        
        // If the scrolling direction is changed on both X and Y it means the
        // scrolling started in one corner and goes diagonal. This will be
        // called ScrollDirectionCrazy
        
        if initialContentOffset.x != scrollView.contentOffset.x &&
            initialContentOffset.y != scrollView.contentOffset.y {
                scrollDirection = .Crazy
        }
        else {
            if initialContentOffset.x > scrollView.contentOffset.x {
                scrollDirection = .Left
            }
            else if initialContentOffset.x < scrollView.contentOffset.x {
                scrollDirection = .Right
            }
            else if initialContentOffset.y > scrollView.contentOffset.y {
                scrollDirection = .Up
            }
            else if initialContentOffset.y < scrollView.contentOffset.y {
                scrollDirection = .Down
            }
            else {
                scrollDirection = .None
            }
        }
        return scrollDirection
    }
    
    func determineScrollDirectionAxis(scrollView: UIScrollView) -> ScrollDirection {
        let scrollDirection = determineScrollDirection(scrollView)
        switch (scrollDirection) {
        case .Left, .Right:
            return .Horizontal
        case .Up, .Down:
            return .Vertical
        default:
            return .None
        }
    }
    
    // MARK: Scroll View - Custom behaviors
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollDirection = determineScrollDirectionAxis(scrollView)
        if scrollDirection == .None {
            var newOffset: CGPoint
            if abs(scrollView.contentOffset.x) > abs(scrollView.contentOffset.y) {
                newOffset = CGPointMake(scrollView.contentOffset.x, initialContentOffset.y)
            }
            else {
                newOffset = CGPointMake(initialContentOffset.x, scrollView.contentOffset.y)
            }
            scrollView.setContentOffset(newOffset, animated: false)
        }
        else if scrollDirection == .Vertical {
            UIView.animateWithDuration(0.3, animations: {
                self.pageControl.layer.opacity = 0
            })
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        initialContentOffset = scrollView.contentOffset
        if (!canScrollHorizontally) {
            println(scrollView.contentSize)
            scrollView.contentSize = CGSizeMake(320, 1136)
            scrollView.contentOffset = initialContentOffset
        }
        else {
            scrollView.contentSize = CGSizeMake(1600, 1136)
        }
    }
    
    // MARK: Page-specific code
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        switch (scrollView.contentOffset.x) {
            case 0:
                pageControl.currentPage = 0
            case 320:
                pageControl.currentPage = 1
            case 640:
                pageControl.currentPage = 2
            case 960:
                pageControl.currentPage = 3
            case 1280:
                pageControl.currentPage = 4
            default:
                break
        }
        switch (scrollView.contentOffset.y) {
            case 0:
                canScrollHorizontally = false
            case 568:
                canScrollHorizontally = true
                UIView.animateWithDuration(0.3, animations: {
                    self.pageControl.layer.opacity = 1
                })
            default:
                break
        }
    }
    
    // MARK: Camera functionality
    @IBAction func didTapCameraButton(sender: UIButton) {
        println("a")
    }
    
    // MARK: Animations
    func move(action: () -> Void, completion: () -> Void = {}) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: nil, animations: {
            action()
            },
            completion: {completed in
                completion()
        })
    }
}