//
//  Neurons.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/17.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Cocoa

class Neurons: NSObject {
    
    var inputFunctionType = InputFunctionType.sum
    var transferFunctionType = TransferFunctionType.step
    
    var inputChannelList = [Channel]()
    
    var b: Double = 1
    var t: Double = 0
    var s: Double = 0
    var a: Double = 0
    var e: Double = 0
    
    var completeAction: (() -> Void)? = nil
    
    func calculate() {
        self.s = InputFunctionCenter.calculate(type: self.inputFunctionType, b: self.b, channels: self.inputChannelList)
        self.a = TransferFunctionCenter.calculate(type: self.transferFunctionType, s: self.s)
        self.e = t - a
        self.adjustment(e: self.e)
        self.completeAction?()
    }
    
    private func adjustment(e: Double) {
        for channel in self.inputChannelList {
            channel.weight = channel.weight + e * channel.inputData
        }
        self.b = self.b + e
    }
    
    func run() {
        self.s = InputFunctionCenter.calculate(type: self.inputFunctionType, b: self.b, channels: self.inputChannelList)
        self.a = TransferFunctionCenter.calculate(type: self.transferFunctionType, s: self.s)
        self.e = t - a
        self.completeAction?()
    }
    
}
