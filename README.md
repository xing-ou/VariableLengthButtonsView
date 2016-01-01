# VariableLengthButtonsView
将 字符串作为btn的title,然后添加到view中
#snapshot
![snapshot.png](https://github.com/xing-ou/VariableLengthButtonsView/blob/master/snapshot.png)
#加入项目
>拷贝 **VariableLengthButtonsView** 到你的项目中，在storyboard上建一个普通的view,设置其类为VariableLengthButtonsView
>然后在右侧属性栏中，确定btn字体大小(fontsize)， 行间距(yoffset)， 左边预留宽度（leftOffset）,右边预留宽度(righitoffset)，
>以及每两个btn之间的宽度(itemoffset)
>之后参照，示例代码，以及VariableLengthButtonsView的注释
#变量和方法
**变量**
```
   @IBInspectable var fontSize :CGFloat = 20
    ///每行默认的相对于上一行的间隔， 默认10
   @IBInspectable var yOffset :CGFloat = 10
    ///所有btn距离左边的最小offset，默认10
   @IBInspectable var leftOffset :CGFloat = 10
    ///所有btn距离右边的边的最小offset，默认10
   @IBInspectable var rightOffset :CGFloat = 10
    ///一行中item的间隔，默认15
   @IBInspectable var itemOffset :CGFloat = 15

```
**方法**
 func addButtons(withTitleArray titleArray:[String],
        andAdditonButtonAttributeSetup btnSetup:((UIButton)->())?,
        andTargetEventSetup targetEventSetup: ((UIButton)->())?)
    
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


```


```
