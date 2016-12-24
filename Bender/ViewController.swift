//
//  ViewController.swift
//  Bender
//
//  Created by Michael Tang on 12/23/16.
//  Copyright © 2016 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!

    @IBOutlet weak var deci: UIButton!
    @IBOutlet weak var percent: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var equal: UIButton!
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var times: UIButton!
    @IBOutlet weak var div: UIButton!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var leftPar: UIButton!
    @IBOutlet weak var rightPar: UIButton!
    @IBOutlet weak var neg: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons: [UIButton] = [self.zero,self.one,self.two,self.three,self.four,self.five,self.six,self.seven,self.eight,self.nine,self.deci,self.percent,self.delete,self.equal,self.plus,self.minus,self.times,self.div,self.clear,self.leftPar,self.rightPar,self.neg]
        buttonOutline(list: buttons)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonOutline(list:[UIButton]) -> Void {
        for button in list {
            button.layer.borderWidth = 0.8
            button.layer.borderColor = UIColor.black.cgColor
        }
    }


}

