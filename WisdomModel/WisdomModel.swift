//
//  WisdomModel.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/19.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Cocoa

class WisdomModel: NSObject {
    var trainDataList = [([Double], Double)]()
    var layerPool = [Layer]()
    
    var trainCount: Int = 0
    var isTrain = true
    
    func train() {
        self.isTrain = true
        let inputLayer = self.layerPool[0] as! InputLayer
        
        let trainData = trainDataList[self.randomIndex()]
        inputLayer.inputData(data: trainData.0, newLable: trainData.1)
        inputLayer.calculate()
    }
    
    func run(realData: [Double]) {
        print("--------------\n运行开始，输入数据:\(realData)")
        self.isTrain = false
        let inputLayer = self.layerPool[0] as! InputLayer
        inputLayer.inputData(data: realData, newLable: 0)
        inputLayer.run()
    }
    
    func createSystem(_ inputLayerInfo: LayerInfoEntity, _ hideLayerInfo: LayerInfoEntity, _ outputLayerInfo: LayerInfoEntity) {
        let inputLayer = InputLayer()
        inputLayer.layerInfo = inputLayerInfo
        inputLayer.createNeurons(withCount: inputLayerInfo.elementsCount)
        self.layerPool.append(inputLayer)
        
        for _ in 0 ..< hideLayerInfo.count {
            let hideLayer = HideLayer()
            hideLayer.layerInfo = hideLayerInfo
            self.layerPool.last!.nextLayer = hideLayer
            hideLayer.createNeurons(withCount: hideLayerInfo.elementsCount)
            self.layerPool.append(hideLayer)
        }
        
        let outputLayer = OutputLayer()
        outputLayer.layerInfo = outputLayerInfo
        outputLayer.createNeurons(withCount: outputLayerInfo.elementsCount)
        self.layerPool.last!.nextLayer = outputLayer
        self.layerPool.append(outputLayer)
        
        outputLayer.completeAction = {() in
            if self.isTrain == false {
                print("运行结束，运行结果:\(outputLayer.neuronsPool[0].a)")
                return
            }
            var isDone = false
            for outputNeurons in outputLayer.neuronsPool {
                if outputNeurons.e == 0 && self.trainCount > self.trainDataList.count {
                    isDone = true
                    break
                }
            }
            if isDone {
                print("第\(self.trainCount)轮训练结束\n本次结果:\(outputLayer.neuronsPool[0].a)\n标准答案:\(outputLayer.label)\n--------------")
                print("训练结束")
                return
            }
            
            print("第\(self.trainCount)轮训练结束\n本次结果:\(outputLayer.neuronsPool[0].a)\n标准答案:\(outputLayer.label)\n--------------")
            self.trainCount += 1
            
            let trainData = self.trainDataList[self.randomIndex()]
            inputLayer.inputData(data: trainData.0, newLable: trainData.1)
            inputLayer.calculate()
        }
        
        inputLayer.createAllConnect()
    }
    
    private func randomIndex() -> Int {
        let max: UInt32 = UInt32.init(self.trainDataList.count)
        let index = arc4random_uniform(max)
        return Int(index)
    }
}

class LayerInfoEntity: NSObject {
    var count: Int = 0
    var elementsCount: Int = 0
    var transferFunctionType = TransferFunctionType.step
    var inputFunctionType = InputFunctionType.sum
}
