// Playground - noun: a place where people can play

import Cocoa

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

valueToHour(0.95)