//
//  ViewController.swift
//  Bender
//
//  Created by Michael Tang on 12/23/16.
//  Copyright © 2016 Michael Tang. All rights reserved.
//  String extension courtesy of serg_zhd

import UIKit
import CoreMotion

public extension String {
    
    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        return self.substring(with: Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex)))
    }
    
}

class ViewController: UIViewController {
    let manager:CMMotionManager = CMMotionManager()
        
    @IBOutlet weak var zero: UIButton!
    
    @IBAction func zeroPressed(_ sender: UIButton) {
        stream.append("0")
        screen.text = screen.text!+String("0")
    }
    @IBAction func onePressed(_ sender: UIButton) {
        stream.append("1")
        screen.text = screen.text!+String("1")
    }
    @IBAction func twoPressed(_ sender: UIButton) {
        stream.append("2")
        screen.text = screen.text!+String("2")
    }
    @IBAction func threePressed(_ sender: UIButton) {
        stream.append("3")
        screen.text = screen.text!+String("3")
    }
    @IBAction func fourPressed(_ sender: UIButton) {
        stream.append("4")
        screen.text = screen.text!+String("4")
    }
    @IBAction func fivePressed(_ sender: UIButton) {
        stream.append("5")
        screen.text = screen.text!+String("5")
    }
    @IBAction func sixPressed(_ sender: UIButton) {
        stream.append("6")
        screen.text = screen.text!+String("6")
    }
    @IBAction func sevenPressed(_ sender: UIButton) {
        stream.append("7")
        screen.text = screen.text!+String("7")
    }
    @IBAction func eightPressed(_ sender: UIButton) {
        stream.append("8")
        screen.text = screen.text!+String("8")
    }
    @IBAction func ninePressed(_ sender: UIButton) {
        stream.append("9")
        screen.text = screen.text!+String("9")
    }
    @IBAction func deciPressed(_ sender: UIButton) {
        stream.append(".")
        screen.text = screen.text!+String(".")
    }
    @IBAction func deletePressed(_ sender: UIButton) {
        if(stream != ""){
            stream.characters.removeLast()
            screen.text = String(screen.text!.characters.dropLast())
        }
    }
    
    @IBAction func leftPar(_ sender: UIButton) {
        stream.append("(")
        screen.text = screen.text!+String("(")
    }
    
    @IBAction func rightPar(_ sender: UIButton) {
        stream.append(")")
        screen.text = screen.text!+String(")")
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        stream.append("+")
        screen.text = screen.text!+String("+")
    }
    
    @IBAction func minusPressed(_ sender: UIButton) {
        stream.append("-")
        screen.text = screen.text!+String("-")
    }
    @IBAction func timesPressed(_ sender: UIButton) {
        stream.append("*")
        screen.text = screen.text!+String("×")
    }
    @IBAction func divPressed(_ sender: UIButton) {
        stream.append("/")
        screen.text = screen.text!+String("/")
    }
    @IBAction func equalPressed(_ sender: UIButton) {
        tokens = lex(s: stream)
        
        if(screen.text == ""){
            invaildExprView()
            return
        }
        
        screen.text!.removeAll()
        stream.removeAll()
    
        
        if(isVaildTokensModel(tokens: tokens)){
            let result:Float = exprModel()
            if(canBeIntegerModel(value: result)){
                screen.text = String(Int64(result))
                tokens.removeAll()
                stream.append(String(Int64(result)))
            
            }else{
                screen.text = String(result)
                tokens.removeAll()
                stream.append(String(result))
            }
            
        }else{
            invaildExprView()
        }
    }
    @IBAction func clearPressed(_ sender: UIButton) {
        view.viewWithTag(1)?.removeFromSuperview()
        if let tag = self.view.viewWithTag(1) {
            tag.removeFromSuperview()
        }
        tokens.removeAll()
        screen.text!.removeAll()
        stream.removeAll()
    }
    @IBAction func negPressed(_ sender: UIButton) {
        tokens = lex(s: stream)
        screen.text!.removeAll()
        stream.removeAll()
        if(isVaildTokensModel(tokens: tokens)){
            equal.sendActions(for: .touchUpInside)
            stream.append("*(-1)")
            equal.sendActions(for: .touchUpInside)
        }else{
            invaildExprView()
        }
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
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var screen: UILabel!
    
    var current:String = ""
    var stream = ""
    var tokens:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons: [UIButton] = [self.zero,self.one,self.two,self.three,self.four,self.five,self.six,self.seven,self.eight,self.nine,self.deci,self.percent,self.delete,self.equal,self.plus,self.minus,self.times,self.div,self.clear,self.leftPar,self.rightPar,self.neg]
     
        buttonOutlineView(list: buttons)
        acclerometerEffect()
        //activateProximitySensor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        view.viewWithTag(1)?.removeFromSuperview()
        manager.stopDeviceMotionUpdates()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        manager.stopDeviceMotionUpdates()
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
                let r = factorModel()
                if(Int64(result*r) > Int64(Int32.max)){
                    overflowView()
                    result = 0
                }else{
                    result *= r
                }
            }
            else if(current == "/"){
                nextModel()
                let r = factorModel()
                if(r == 0){
                    overflowView()
                    return 0
                }
                if(Int64(result/r) > Int64(Int32.max)){
                    overflowView()
                    result = 0
                }else{
                    result /= r
                }
            }else{
                nextModel()
                let r = factorModel()
                if(Int64(result*r) > Int64(Int32.max)){
                    overflowView()
                    result = 0
                }else{
                    result *= r
                }
                nextModel()
            }
        }
        return result
    }
    
    func factorModel() -> Float {
        var result:Float = 0
        current = tokens.first!
        if(current == "("){
            nextModel()
            result = exprModel()
            nextModel()
        }else if(current == "-"){
            nextModel()
            result = -1*Float(current)!
            nextModel()
        }
        else{
            result = Float(current)!
            nextModel()
        }
        return result
    }
    
    func nextModel() -> Void {
        if(tokens.count > 1){
            tokens.remove(at: 0)
            current = tokens.first!
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
    
    func lex(s:String) -> [String] {
        var l = 0
        var i = 0
        var tokens:[String] = []
        
        while i < s.characters.count {
            let index = s.index(s.startIndex, offsetBy: i)
            if(s[index] == "+"){
                let subToken = s.substring(l..<i)
                if(subToken != ""){
                    tokens.append(subToken)
                }
                tokens.append("+")
                l = i+1
            }else if(s[index] == "-"){
                let subToken = s.substring(l..<i)
                if(subToken != ""){
                    tokens.append(subToken)
                }
                tokens.append("-")
                l = i+1
            }
            else if(s[index] == "*"){
                let subToken = s.substring(l..<i)
                if(subToken != ""){
                    tokens.append(subToken)
                }
                tokens.append("*")
                l = i+1
            }
            else if(s[index] == "/"){
                let subToken = s.substring(l..<i)
                if(subToken != ""){
                    tokens.append(subToken)
                }
                tokens.append("/")
                l = i+1
            }
            else if(s[index] == "("){
                let subToken = s.substring(l..<i)
                if(subToken != ""){
                    tokens.append(subToken)
                }
                tokens.append("(")
                l = i+1
            }
            else if(s[index] == ")"){
                let subToken = s.substring(l..<i)
                if(subToken != ""){
                    tokens.append(subToken)
                }
                tokens.append(")")
                l = i+1
            }
            i += 1
        }
        let subToken = s.substring(l..<i)
        if(subToken != ""){
            tokens.append(subToken)
        }
        return tokens
    }
    
    func isVaildTokensModel(tokens:[String]) -> Bool {
        var parenCheck:Int = 0
        for i in 0..<tokens.count {
            let i = i
            if(!notOperator(token: tokens[i]) && (i == tokens.count-1)){
                return false
            }
            else if(!notOperator(token: tokens[i]) && (!notOperator(token: tokens[i+1]))){
                return false
            }else if(tokens[i] == "("){
                parenCheck += 1
            }else if(tokens[i] == ")"){
                parenCheck -= 1
                if(tokens[i-1] == "("){
                    return false
                }
            }
            else if (Float(tokens[i]) == nil && notOperator(token: tokens[i])) {
                return false
            }
        }
        if(parenCheck != 0){
            return false
        }
        return true
    }
    
    func overflowView() -> Void {
        let devicebound:CGRect = UIScreen.main.bounds
        let alert:UILabel = UILabel(frame: CGRect(x: 0, y: -50, width: devicebound.width, height: 65))
        alert.backgroundColor = UIColor(red: CGFloat(132.0/255.0), green: CGFloat(113.0/255.0), blue: CGFloat(171.0/255.0), alpha: 1.0)
        alert.textColor = UIColor.white
        alert.text = "Overflow"
        alert.textAlignment = .center
        alert.tag = 1
        self.view.addSubview(alert)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options:UIViewAnimationOptions(rawValue: 0), animations: {
            alert.center.y += 55
        }, completion: nil)
    }
    
    func invaildExprView() -> Void {
        let devicebound:CGRect = UIScreen.main.bounds
        let alert:UILabel = UILabel(frame: CGRect(x: 0, y: -50, width: devicebound.width, height: 65))
        alert.backgroundColor = UIColor.red
        alert.textColor = UIColor.white
        alert.text = "Unable to evaulate expression"
        alert.textAlignment = .center
        alert.tag = 1
        self.view.addSubview(alert)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options:.curveEaseInOut, animations: {
            alert.center.y += 55
        }, completion: nil)
    }
    
    func acclerometerEffect() -> Void {
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.02
            manager.startDeviceMotionUpdates(to: OperationQueue.main) {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                
                if let x = data?.userAcceleration.x,
                    x < -2.5 {
                    self!.delete.sendActions(for: UIControlEvents.touchUpInside)
                }else if let x = data?.userAcceleration.x,
                    x > 2.5 {
                    self!.clear.sendActions(for: UIControlEvents.touchUpInside)
                }
            }
        }
    }
}



