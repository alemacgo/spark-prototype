//
//  ValueToHour.swift
//  Prototype
//
//  Created by Alejandro on 10/22/14.
//  Copyright (c) 2014 Spark. All rights reserved.
//

import Foundation


let rangeBoundaries = Array(map(0...24) { Float($0)/24})
var hours = Array(map(0...23) { "\($0):00" })

func valueToHour(value: Float) -> String {
    var index = 0
    while (index < 24) {
        if value < rangeBoundaries[index + 1] {
            return hours[index]
        }
        index++
    }
    return "23:00"
}