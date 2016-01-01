# VariableLengthButtonsView
将 字符串作为btn的title,然后添加到view中
#snapshot
![snapshot.png](https://github.com/xing-ou/VariableLengthButtonsView/blob/master/snapshot.png) ![snapshot2.png](https://github.com/xing-ou/VariableLengthButtonsView/blob/master/snapshot2.png)
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

> func addButtons(withTitleArray titleArray:[String],
>                 andAdditonButtonAttributeSetup btnSetup:((UIButton)->())?,
>                 andTargetEventSetup targetEventSetup: ((UIButton)->())?)



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


> func appendButton(withTitle title:String ,
>
>                   andAdditonButtonAttributeSetup btnSetup:((UIButton)->())?,
>
>                   andTargetEventSetup targetEventSetup: ((UIButton)->())?)



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



>  func removeAllBtns()

```
//删除所有btn
self.buttonsview.removeAllBtns()
```

