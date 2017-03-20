//
//  main.swift
//  GZJ
//
//  Created by 孙俊 on 2017/3/17.
//  Copyright © 2017年 孙俊. All rights reserved.
//

import Foundation

/* 设定
 苹果 = 0
 香蕉 = 1
 颜色（苹果_红色）= 2
 颜色（香蕉_黄色）= 3
 形状（苹果_圆形）= -1
 形状（香蕉_弯形）= 1
 脆度（苹果_脆） = -1
 脆度（香蕉_不脆） = 1
 */

let dataList: [([Double], Double)] = [([2.0, -1.0, -1.0], 0),
                                      ([3.0, 1.0, 1.0], 1)]


let model = WisdomModel()

let inputLayerInfo = LayerInfoEntity()
inputLayerInfo.elementsCount = 3

let hideLayerInfo = LayerInfoEntity()
hideLayerInfo.count = 1
hideLayerInfo.elementsCount = 3
hideLayerInfo.inputFunctionType = .sum
hideLayerInfo.transferFunctionType = .step

let outputLayerInfo = LayerInfoEntity()
outputLayerInfo.elementsCount = 1
outputLayerInfo.inputFunctionType = .sum
outputLayerInfo.transferFunctionType = .step

model.createSystem(inputLayerInfo, hideLayerInfo, outputLayerInfo)

model.trainDataList = dataList
model.train()

model.run(realData: [2.0, -1.0, -1.0])
model.run(realData: [3.0, 1.0, 1.0])
