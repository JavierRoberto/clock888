//
//  NSIntervalExtension.swift
//  8:88
//
//  Created by Javier Roberto on 02/10/2018.
//  Copyright © 2018 funtastic. All rights reserved.
//

import Foundation


extension TimeInterval {
    var secondMS: String {
        return String(format:"%02d:%02d", second, millisecond)
    }
    var second: Int {
        return Int(self.truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        return Int((self*100).truncatingRemainder(dividingBy: 100) )
    }
    
    var timeTo888: String {
        let secondsDistance = self.distance(to: 8.88)
        let secondsTo8 = Int(secondsDistance.truncatingRemainder(dividingBy: 60))
        let milisecondsTo88 = Int((secondsDistance*100).truncatingRemainder(dividingBy: 100) )
        return String(format:"%02d:%02d", abs(secondsTo8), abs(milisecondsTo88))
    }
}
