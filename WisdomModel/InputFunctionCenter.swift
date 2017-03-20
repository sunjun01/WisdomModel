//
//  InputFunctionCenter.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/19.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Cocoa

enum InputFunctionType {
    case sum
}

class InputFunctionCenter: NSObject {

    class func calculate(type: InputFunctionType, b: Double, channels: [Channel]) -> Double {
        switch type {
        case .sum:
            return self.sum(b: b, channels: channels)
        }
    }
    
    class func sum(b: Double, channels: [Channel]) -> Double {
        var sum: Double = 0
        for channel in channels {
            sum += (channel.inputData * channel.weight)
        }
        return sum + b
    }
}
