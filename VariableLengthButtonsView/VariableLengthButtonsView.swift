//
//  VariableLengthButtonsView.swift
//  VariableLengthButtonsView
//
//  Created by 苟欣 on 16/1/1.
//  Copyright © 2016年 苟欣. All rights reserved.
//

import UIKit

class VariableLengthButtonsView: UIView {
    
    // MARK : - 可以在storyboard中通过面板设置的值
    ///需要显示的btn的字体大小,默认 fontsize为20
   @IBInspectable var fontSize :CGFloat = 20
    ///每行默认的相对于上一行的间隔， 默认10
   @IBInspectable var yOffset :CGFloat = 10
    ///所有btn距离左边的最小offset，默认10
   @IBInspectable var leftOffset :CGFloat = 10
    ///所有btn距离右边的边的最小offset，默认10
   @IBInspectable var rightOffset :CGFloat = 10
    ///一行中item的间隔，默认15
   @IBInspectable var itemOffset :CGFloat = 15
    ///记录当前要添加的btn的x y坐标，以及x y方向上还有多少剩余空间
    private var isCurrentValueSeted = false
    private var currentAvaliableYlength :CGFloat = 0
    private var currentAvaliableXlength :CGFloat = 0
    private var currentXPosition :CGFloat = 0
    private var currentYPosition :CGFloat = 0
    /**
     向view中添加一组buttons，如果一行空间不够，会自动添加到下一行
     - parameter titleArray : 包含buttons的title的数组
     - parameter btnSetup :一个闭包，用于设置btn的属性，比如：背景色，title color等，也可设为Nil，使用系统btn的默认设置(蓝字白底)。（**不要在这里设置字体大小**，请通过VariableLengthButtonsView的fontSize变量统一设置，因为btn的高度是通过统一的fontSize进行计算的，而不是你在btnSetup里设置的字体）
     - parameter targetEventSetup:一个闭包，用于设置按钮的事件。传入nil不添加事件。(也可在btnsetup中添加事件，我不推荐，因为分开更能让人更清晰你做了什么)
     
     ```
     示例代码：
     let buttonTitles = ["天涯明月刀","御龙在天","我的世界","炉石","英雄联盟", "坦克世界","酥酥"]
     buttonsview.addButtons(withTitleArray: buttonTitles,
     andAdditonButtonAttributeSetup: {
        btn in
        //设置背景色
        btn.backgroundColor = UIColor(red: 0xfe/255, green: 0xff/255, blue: 0xff/255, alpha: 1)
        //设置title颜色
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //增加shadow
        btn.layer.shadowOffset = CGSizeMake(0, 1)
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowColor = UIColor.blackColor().CGColor
     },
     andTargetEventSetup: {
        btn in
        btn.addTarget(self, action: "btnEventHandler:", forControlEvents: .TouchUpInside)
     })
     
     func btnEventHandler(sender:UIButton){
        //添加你自己的业务逻辑
        print("cliked \(sender.titleLabel?.text)")
     }
     ```
     */
    func addButtons(withTitleArray titleArray:[String],
        andAdditonButtonAttributeSetup btnSetup:((UIButton)->())?,
        andTargetEventSetup targetEventSetup: ((UIButton)->())?){
        
        if(!isCurrentValueSeted){
            isCurrentValueSeted = true
            currentAvaliableYlength = self.bounds.height
            currentAvaliableXlength = UIScreen.mainScreen().bounds.width - leftOffset - rightOffset
            currentXPosition = leftOffset
            currentYPosition = yOffset
        }
        
        //循环遍历titles
        for title in titleArray {
            self.appendButton(withTitle: title, andAdditonButtonAttributeSetup: btnSetup, andTargetEventSetup: targetEventSetup)
        }
        
    }
    /**
     向view中添加一个button，如果一行空间不够，会自动添加到下一行
     - parameter title : button的title
     - parameter btnSetup :一个闭包，用于设置btn的属性，比如：背景色，title color等，也可设为Nil，使用系统btn的默认设置(蓝字白底)。（**不要在这里设置字体大小**，请通过VariableLengthButtonsView的fontSize变量统一设置，因为btn的高度是通过统一的fontSize进行计算的，而不是你在btnSetup里设置的字体）
     - parameter targetEventSetup:一个闭包，用于设置按钮的事件。传入nil不添加事件。(也可在btnsetup中添加事件，我不推荐，因为分开更能让人更清晰你做了什么)
     
     ```
     示例代码：
     self.buttonsview.appendButton(withTitle: title, 
        andAdditonButtonAttributeSetup: {
            btn in
            //设置背景色
            btn.backgroundColor = UIColor(red: 0xfe/255, green: 0xff/255, blue: 0xff/255, alpha: 1)
            //设置title颜色
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            //增加shadow
            btn.layer.shadowOffset = CGSizeMake(0, 1)
            btn.layer.shadowOpacity = 0.3
            btn.layer.shadowColor = UIColor.blackColor().CGColor
        },
        andTargetEventSetup: {
            btn in
            btn.addTarget(self, action: "btnEventHandler:", forControlEvents: .TouchUpInside)
     })

     func btnEventHandler(sender:UIButton){
        //添加你自己的业务逻辑
        print("cliked \(sender.titleLabel?.text)")
     }
     ```
    */
    func appendButton(withTitle title:String ,
        andAdditonButtonAttributeSetup btnSetup:((UIButton)->())?,
        andTargetEventSetup targetEventSetup: ((UIButton)->())?){
        if(!isCurrentValueSeted){
            isCurrentValueSeted = true
            currentAvaliableYlength = self.bounds.height
            currentAvaliableXlength = UIScreen.mainScreen().bounds.width - leftOffset - rightOffset
            currentXPosition = leftOffset
            currentYPosition = yOffset
        }
        //print("bounds\(self.bounds)")
        //计算出text的长度
        let textsize = caculateStringSize(title)
        for var i in [1,2]{//准备两次循环，为了处理需要换行的title
            i = i + 1//无意义，只是没用i的话会有警告
            if( currentAvaliableYlength < textsize.height + yOffset){//如果没有了剩余空间
                return
            }else{//竖直方向上有空间，接着判断水平方向上是否有空间
                if(currentAvaliableXlength > textsize.width ){//x 方向上有空间
                    let btn = UIButton(type: .System)
                    btn.frame = CGRectMake(currentXPosition, currentYPosition, textsize.width, textsize.height)
                    btn.setTitle(title, forState: .Normal)
                    if let additonButtonAttributeSetup = btnSetup {
                        additonButtonAttributeSetup(btn)
                    }
                    if let _targetEventSetup = targetEventSetup{
                        _targetEventSetup(btn)
                    }
                    self.addSubview(btn)
                    currentXPosition += (textsize.width + itemOffset)
                    currentAvaliableXlength -= (textsize.width + itemOffset)
                    //print("\(i)add a btn size\(textsize)")
                    break
                }else{//如果x方向上没有了空间，则准备跳到下一行
                    currentAvaliableXlength = UIScreen.mainScreen().bounds.width - leftOffset - rightOffset
                    currentAvaliableYlength -= (textsize.height + yOffset)
                    currentXPosition = leftOffset
                    currentYPosition += (yOffset + textsize.height)
                }
            }
        }
    }
    ///删除本view内的所有btn，下次添加又会从左上角开始
    func removeAllBtns(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        isCurrentValueSeted = false
    }
    
    ///计算出title size的函数
    private func caculateStringSize(str:String)->CGRect{
        let attributes = [NSFontAttributeName:UIFont.systemFontOfSize(fontSize)]
        let textsize = (str as NSString).boundingRectWithSize(CGSize(width: 320, height: 100), options: [ .TruncatesLastVisibleLine,.UsesFontLeading,.UsesLineFragmentOrigin], attributes: attributes, context: nil)
        return textsize
    }
}
