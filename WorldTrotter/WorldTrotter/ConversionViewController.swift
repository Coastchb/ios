//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by 操海兵 on 2019/6/16.
//  Copyright © 2019 Coast. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusValue()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)          // the converted function and its parameters ???
        } else {
            return nil
        }
    }
    
    @IBOutlet var textField: UITextField!
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)      // the Measurement class and unit parameter ???
        } else {
            fahrenheitValue = nil
        }
    }
    
    func updateCelsiusValue() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value
            ))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConvertViewController loaded its view")
        updateCelsiusValue()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn from: NSRange,
                   replacementString string: String) -> Bool {              // the function name and variable name are the same ???
        //print("Current text: \(textField.text)")
        //print("Replacement text: \(string)")
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of:".")
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        }
        return true
    }
}

