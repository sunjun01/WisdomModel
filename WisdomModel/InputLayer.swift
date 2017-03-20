//
//  InputLayer.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/19.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Cocoa

class InputLayer: Layer {
    
    func inputData(data: [Double], newLable: Double) {
        self.label = newLable
        for number in data {
            for neurons in self.neuronsPool {
                neurons.a = number
            }
        }
    }
}
