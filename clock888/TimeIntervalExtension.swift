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
        var secondsTo8 = abs(8 - second)
        var milisecondsTo88 = 88 - millisecond
        
        if milisecondsTo88 < 0 {
            secondsTo8 = secondsTo8 - 1
            milisecondsTo88 = 100 - abs(milisecondsTo88)
        }
        
        return String(format:"%02d:%02d", secondsTo8, milisecondsTo88)
    }
}
