//
//  ViewController.swift
//  VariableLengthButtonsView
//
//  Created by 苟欣 on 16/1/1.
//  Copyright © 2016年 苟欣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func removeAll(sender: UIButton) {
        self.buttonsview.removeAllBtns()
    }
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var addbtn: UIButton!
    var i = 1
    @IBAction func appendButtons(sender: UIButton) {
        var title = ""
        if(textfield.text == ""){
            title = "hell\(i++)"
        }else{
            title = self.textfield.text!
        }
        self.buttonsview.appendButton(withTitle: title,
            andAdditonButtonAttributeSetup: {
            btn in
                btn.backgroundColor = UIColor(red: 0xfe/255, green: 0xff/255, blue: 0xff/255, alpha: 1)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.layer.shadowOffset = CGSizeMake(0, 1)
            btn.layer.shadowOpacity = 0.3
            btn.layer.shadowColor = UIColor.blackColor().CGColor
            }, andTargetEventSetup: { btn in
                btn.addTarget(self, action: "btnEventHandler:", forControlEvents: .TouchUpInside)
        })
    }
    func btnEventHandler(sender:UIButton){
        print("cliked \(sender.titleLabel?.text)")
    }
    
    
    @IBOutlet weak var buttonsview: VariableLengthButtonsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       let buttonTitles = ["天涯明月刀","御龙在天","我的世界","炉石","英雄联盟", "坦克世界","酥酥"]
        buttonsview.addButtons(withTitleArray: buttonTitles, andAdditonButtonAttributeSetup: {
            btn in
            btn.backgroundColor = UIColor(red: 0xfe/255, green: 0xff/255, blue: 0xff/255, alpha: 1)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.layer.shadowOffset = CGSizeMake(0, 1)
            btn.layer.shadowOpacity = 0.3
            btn.layer.shadowColor = UIColor.blackColor().CGColor
            },
            andTargetEventSetup: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }

    

}

