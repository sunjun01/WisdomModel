
Wisdom Model是一个人工神经网络框架，现在仅仅是很初级的版本。

开发目的：将人工神经网络搬到iOS设备上，所以采用Swift语言开发。

当前项目架构设计：

WisdomModel类：智慧模型的主体，包含整个神经网络的全部。

Layer类：神经网络层的实现，这是一个基类，目前有三个子类（InputLayer、HideLayer、OutputLayer）

InputLayer类：输入层，数据由这一层输入智慧模型内。输入层只有一层。

HideLayer类：隐层，中间的计算层。可以有任意多个。

OutputLayer类：输出层，从这一层，我们可以得到计算的结果。

Neurons类：神经元，计算的最基本单位。有多个输入，仅有一个输出。

Channel类：神经元之间的信息传输通道。

使用方法：

1、创建WisdomModel对象

let model = WisdomModel()

2、设计输入层结构

    let inputLayerInfo = LayerInfoEntity()
    inputLayerInfo.elementsCount = 3 //输入层包含3个神经元，每个神经元接收一个数据特性

3、设计隐层结构

    let hideLayerInfo = LayerInfoEntity()
    hideLayerInfo.count = 1 //隐层只有一层
    hideLayerInfo.elementsCount = 3 //每层包含3个神经元
    hideLayerInfo.inputFunctionType = .sum //输入函数选择“加权求和”
    hideLayerInfo.transferFunctionType = .step //传输函数选择 "Step"

4、设计输出层结构

    let outputLayerInfo = LayerInfoEntity()
    outputLayerInfo.elementsCount = 1
    outputLayerInfo.inputFunctionType = .sum
    outputLayerInfo.transferFunctionType = .step

5、根据上面设定的信息生成神经网络

    model.createSystem(inputLayerInfo, hideLayerInfo, outputLayerInfo)

6、导入训练数据（训练数据由数据本身和一个标准答案组成）

    let dataList: [([Double], Double)] = [([2.0, -1.0, -1.0], 0), ([3.0, 1.0, 1.0], 1)]
                                      
7、启动训练

    model.train()

8、训练完成后使用真实数据进行验证

    model.run(realData: [2.0, -1.0, -1.0])
    model.run(realData: [3.0, 1.0, 1.0])
