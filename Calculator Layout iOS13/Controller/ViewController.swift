//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    //privateをつけることにより他のクラスからアクセスできなくなる。
    private var isFinishedTypingNumber:Bool = true
    
    private var displayValue:Double{
        get{
            guard let number = Double(displayLabel.text!) else{
                fatalError("Cannot convert display label text to a DOuble.")
            }
            return number
        }
        set{
            displayLabel.text = String(newValue)
        }
    }
    
    private var calculator = CalculatorLogic()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            
            //nilでないなら値を更新する
            if let result = calculator.calculate(symbol: calcMethod){
                displayValue = result
            }
        }
    }
    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
        if let numValue = sender.currentTitle {
            
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isFinishedTypingNumber = false
            }else{
                if numValue == "." {
                    
                    
                    //floor(切り捨て)と通常が同じだったら、小数点がないことが確認できる。boolで判断
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                    
                }
                displayLabel.text = displayLabel.text! + numValue
            }
            
        }
        
    }
    

}

