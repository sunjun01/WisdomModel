//
//  Channel.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/19.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Cocoa

class Channel: NSObject {
    var fromNeuron: Neurons? = nil
    var toNeuron: Neurons? = nil
    var inputData: Double = 0
    var weight: Double = 1
}
