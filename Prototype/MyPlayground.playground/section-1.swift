// Playground - noun: a place where people can play

import UIKit

// Assuming 320 x 568
func pageMargins(point: CGPoint) -> CGPoint {
    var result = CGPoint()
    if point.x < 160 {
        result.x = 0
    }
    else if point.x < 480 {
        result.x = 320
    }
    else if point.x < 800 {
        result.x = 640
    }
    else if point.x < 1120 {
        result.x = 960
    }
    else {
        result.x = 1280
    }
    
    if point.y < 284 {
        result.y = 0
    }
    else if point.y < 852 {
        result.y = 568
    }
    else {
        result.y = 1704
    }
    
    return result
}

pageMargins(CGPointMake(160, 0))