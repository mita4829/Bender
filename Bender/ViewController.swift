//
//  ViewController.swift
//  Bender
//
//  Created by Michael Tang on 12/23/16.
//  Copyright © 2016 Michael Tang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var zero: UIButton!
    
    @IBAction func zeroPressed(_ sender: UIButton) {
        tmpFloatValue.append("0")
        screen.text = screen.text!+String("0")
    }
    @IBAction func onePressed(_ sender: UIButton) {
        tmpFloatValue.append("1")
        screen.text = screen.text!+String("1")
    }
    @IBAction func twoPressed(_ sender: UIButton) {
        tmpFloatValue.append("2")
        screen.text = screen.text!+String("2")
    }
    @IBAction func threePressed(_ sender: UIButton) {
        tmpFloatValue.append("3")
        screen.text = screen.text!+String("3")
    }
    @IBAction func fourPressed(_ sender: UIButton) {
        tmpFloatValue.append("4")
        screen.text = screen.text!+String("4")
    }
    @IBAction func fivePressed(_ sender: UIButton) {
        tmpFloatValue.append("5")
        screen.text = screen.text!+String("5")
    }
    @IBAction func sixPressed(_ sender: UIButton) {
        tmpFloatValue.append("6")
        screen.text = screen.text!+String("6")
    }
    @IBAction func sevenPressed(_ sender: UIButton) {
        tmpFloatValue.append("7")
        screen.text = screen.text!+String("7")
    }
    @IBAction func eightPressed(_ sender: UIButton) {
        tmpFloatValue.append("8")
        screen.text = screen.text!+String("8")
    }
    @IBAction func ninePressed(_ sender: UIButton) {
        tmpFloatValue.append("9")
        screen.text = screen.text!+String("9")
    }
    @IBAction func deciPressed(_ sender: UIButton) {
        if(!tmpFloatValue.contains(".")){
            tmpFloatValue.append(".")
            screen.text = screen.text!+String(".")
        }
    }
    @IBAction func deletePressed(_ sender: UIButton) {
        if(tmpFloatValue.characters.count > 0){
            tmpFloatValue = String(tmpFloatValue.characters.dropLast())
            screen.text = String(screen.text!.characters.dropLast())
        }
        if(!notOperator(token: String(screen.text!.characters.last!))){
            screen.text = String(screen.text!.characters.dropLast())
            exprs.removeLast()
        }
    }
    
    
    @IBAction func plusPressed(_ sender: UIButton) {
        if(tmpFloatValue != ""){
            exprs.append(tmpFloatValue)
        }
        if(exprs.count > 0 && notOperator(token: exprs.last!)){
            tmpFloatValue.removeAll()
            exprs.append("+")
            screen.text = screen.text!+String("+")
        }
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        if(tmpFloatValue != ""){
            exprs.append(tmpFloatValue)
        }
        if(exprs.count > 0 && notOperator(token: exprs.last!)){
            tmpFloatValue.removeAll()
            exprs.append("-")
            screen.text = screen.text!+String("-")
        }
 
    }
    @IBAction func timesPressed(_ sender: UIButton) {
        if(tmpFloatValue != ""){
            exprs.append(tmpFloatValue)
        }
        if(exprs.count > 0 && notOperator(token: exprs.last!)){
            tmpFloatValue.removeAll()
            exprs.append("*")
            screen.text = screen.text!+String("×")
        }

    }
    @IBAction func divPressed(_ sender: UIButton) {
        if(tmpFloatValue != ""){
            exprs.append(tmpFloatValue)
        }
        if(exprs.count > 0 && notOperator(token: exprs.last!)){
            tmpFloatValue.removeAll()
            exprs.append("/")
            screen.text = screen.text!+String("/")
        }
    }
    @IBAction func equalPressed(_ sender: UIButton) {
        if(exprs.count > 0){
            if(tmpFloatValue != ""){
                exprs.append(tmpFloatValue)
            }
            tmpFloatValue.removeAll()
            if(notOperator(token: exprs.last!)){
                let result = exprModel()
                if(canBeIntegerModel(value: result)){
                    screen.text = String(Int(result))
                    exprs.removeAll()
                    tmpFloatValue = String(Int(result))
                    
                }else{
                    screen.text = String(result)
                    exprs.removeAll()
                    tmpFloatValue = String(result)
                    
                }
            }
        }
    }
    @IBAction func clearPressed(_ sender: UIButton) {
        exprs.removeAll()
        tmpFloatValue.removeAll()
        screen.text!.removeAll()
    }
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
    
    @IBOutlet weak var screen: UILabel!
    var exprs:[String] = []
    var tmpFloatValue:String = ""
    var current:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons: [UIButton] = [self.zero,self.one,self.two,self.three,self.four,self.five,self.six,self.seven,self.eight,self.nine,self.deci,self.percent,self.delete,self.equal,self.plus,self.minus,self.times,self.div,self.clear,self.leftPar,self.rightPar,self.neg]
     
        buttonOutlineView(list: buttons)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonOutlineView(list:[UIButton]) -> Void {
        for button in list {
            button.layer.borderWidth = 0.6
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func canBeIntegerModel(value:Float) -> Bool{
        let testDouble:Bool = value.truncatingRemainder(dividingBy: 1) == 0
        return testDouble
    }
    
    func exprModel() -> Float {
        var result = termModel()
        while(current == "+" || current == "-") {
            if(current == "+"){
                nextModel()
                result += termModel()
            }
            else{
                nextModel()
                result -= termModel()
            }
        }
        return Float(result)
    }
    
    func termModel() -> Float {
        var result = factorModel()
        while (current == "*" || current == "/" || current == "("){
            if current == "*"{
                nextModel()
                result *= factorModel()
            }
            else if(current == "/"){
                nextModel()
                result /= factorModel()
            }else{
                nextModel()
                result *= factorModel()
                nextModel()
            }
        }
        return result
    }
    
    func factorModel() -> Float {
        var result:Float = 0
        current = exprs.first!
        if(current == "("){
            nextModel()
            result = exprModel()
            nextModel()
        }else{
            result = Float(current)!
            nextModel()
        }
        return result
    }
    
    func nextModel() -> Void {
        if(exprs.count > 1){
            exprs.remove(at: 0)
            current = exprs.first!
        }
    }
    
    func notOperator(token:String) -> Bool {
        let ops = ["+","-","*","/"]
        for char in ops {
            if (token == char) {
                return false
            }
        }
        return true
    }
    func displayView(char:Character) -> Void{
        screen.text = screen.text!+String(char)
    }
}

