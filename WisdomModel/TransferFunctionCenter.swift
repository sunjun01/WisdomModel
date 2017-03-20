//
//  TransferFunctionCenter.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/19.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Cocoa

enum TransferFunctionType {
    case step
    case sgn
    case linear
    case ramp
    case sigmoid
}

class TransferFunctionCenter: NSObject {
    
   class func calculate(type: TransferFunctionType, s: Double) -> Double {
        switch type {
        case .step:
            return self.step(s: s)
        case .sgn:
            return self.sgn(s: s)
        case .linear:
            return self.linear(s: s)
        case .ramp:
            return self.ramp(s: s)
        case .sigmoid:
            return self.sigmoid(s: s)
        }
    }
    
   class func step(s: Double) -> Double {
        if s > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    class func sgn(s: Double) -> Double {
        if s < 0 {
            return -1
        } else {
            return 1
        }
    }
    
    class func linear(s: Double) -> Double {
        return s
    }
    
    class func ramp(s: Double) -> Double {
        if s < 0 {
            return 0
        }
        if s >= 0 && s <= 1 {
            return s
        } else {
            return 1
        }
    }
    
    class func sigmoid(s: Double) -> Double {
        return 1 / (1 + exp(-1 * s))
    }

    class func tanh(s: Double) -> Double {
        return (exp(s) - exp(-1 * s)) / (exp(s) + exp(-1 * s))
    }
}
