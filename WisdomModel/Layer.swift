//
//  Layer.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/19.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Cocoa

class Layer: NSObject {
    var neuronsPool = [Neurons]()
    var count: Int = 0
    var nextLayer: Layer? = nil
    var label: Double = 0
    var layerInfo: LayerInfoEntity! = nil
    
    var completeAction: (() -> Void)? = nil
    
    func calculate() {
        self.count = self.neuronsPool.count
        for neurons in self.neuronsPool {
            neurons.calculate()
        }
    }
    
    func run() {
        self.count = self.neuronsPool.count
        for neurons in self.neuronsPool {
            neurons.run()
        }
    }
    
    func createAllConnect() {
        if self.nextLayer == nil {
            return
        }
        for selfNeurons in self.neuronsPool {
            for nextNeurons in self.nextLayer!.neuronsPool {
                let channel = Channel()
                channel.fromNeuron = selfNeurons
                nextNeurons.inputChannelList.append(channel)
            }
        }
        self.nextLayer!.createAllConnect()
    }
    
    func makeOutpuData() {
        if self.nextLayer == nil {
            return
        }
        
        var outputData = [Double]()
        for neurons in self.neuronsPool {
            outputData.append(neurons.a)
        }
        
        for (index, data) in outputData.enumerated() {
            for nextNeurons in self.nextLayer!.neuronsPool {
                nextNeurons.inputChannelList[index].inputData = data
                nextNeurons.t = self.label
            }
        }
    }
    
    func nextCalculate() {
        if self.nextLayer != nil {
            self.nextLayer!.label = self.label
            self.nextLayer!.calculate()
        } else {
            self.completeAction?()
        }
    }
    
    func createNeurons(withCount count: Int) {
        self.count = count
        for _ in 0 ..< count {
            let new = self.newNeurons()
            new.completeAction = {() in
                self.count -= 1
                if self.count == 0 {
                    self.makeOutpuData()
                    self.nextCalculate()
                }
            }
            new.inputFunctionType = self.layerInfo.inputFunctionType
            new.transferFunctionType = self.layerInfo.transferFunctionType
            self.neuronsPool.append(new)
        }
    }
    
    func newNeurons() -> Neurons {
        return Neurons()
    }
}
