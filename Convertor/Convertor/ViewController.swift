//
//  ViewController.swift
//  Convertor
//
//  Created by Bharat Mahajan on 10/01/19.
//  Copyright © 2019 BharatMahajan. All rights reserved.
//

import UIKit
enum  UnitType:Int {
    case Temperature = 0
    case Volume = 1
}
class ViewController: UIViewController,UIActionSheetDelegate,UITextFieldDelegate {

    let arrUnitConvertors = ["Temperature", "Volume"]
    let arrTempUnits = ["Kelvin (K)", "Celsius (C)", "Fahrenheit (F)"]
    let arrVolUnits = ["Litre (l)","Mililitre (ml)","US liquid gallon (US gal)"]
    var selectedUnitType = -1
    var selectedInputUnit = -1
    var selectedOutputUnit = -1
    var strInputValue = ""
    var strOutputValue = ""
    var inputTxtValue:Float = 0.0
    var outputTxtValue:Float = 0.0

    @IBOutlet weak var btnInputUnit: UIButton!
    @IBOutlet weak var lblOutputValue: UILabel!
    
    @IBOutlet weak var btnConvert: UIButton!
    @IBOutlet weak var btnOutputUnit: UIButton!
    @IBOutlet weak var txtInputValue: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        segmentedControl.removeAllSegments()
       for items in arrUnitConvertors
       {
        segmentedControl.insertSegment(withTitle: items, at: segmentedControl.numberOfSegments, animated: false)
        }
        segmentedControl.selectedSegmentIndex = 0
        selectedUnitType = UnitType.Temperature.rawValue
    }
    
    // MARK: - Button Actions
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        selectedUnitType = sender.selectedSegmentIndex
        strInputValue = ""
        txtInputValue.text = strInputValue
        btnInputUnit.setTitle("Input Unit", for: .normal)
        btnOutputUnit.setTitle("Output Unit", for: .normal)
        selectedInputUnit  = -1
        selectedOutputUnit = -1
    }
    
    @IBAction func selectUnitValueAction(_ sender: UIButton) {
        self.view.endEditing(true)
        var isInputType = false
        if sender.tag == 0
        {
            isInputType = true
        }
        else
        {
            isInputType = false
        }
        if selectedUnitType == UnitType.Temperature.rawValue
        {
            showActionSheetWithValuesFrom(selectedType: selectedUnitType, isInput: isInputType)
        }
        else if selectedUnitType == UnitType.Volume.rawValue
        {
            showActionSheetWithValuesFrom(selectedType: selectedUnitType, isInput: isInputType)
        }
    }
    
    @IBAction func convertValue(_ sender: UIButton) {
        self.view.endEditing(true)
        strInputValue = txtInputValue.text!
        if selectedOutputUnit == -1 || selectedInputUnit == -1
        {
            showAlertWithMessage("Select input/output unit")
            return
        }
        if txtInputValue.text?.count == 0
        {
            showAlertWithMessage("Select input value")
            return
        }
        inputTxtValue = Float(strInputValue)!
        outputTxtValue = 0.0
        if selectedInputUnit == selectedOutputUnit
        {
            lblOutputValue.text = strInputValue
            return
        }
        if selectedUnitType == UnitType.Temperature.rawValue
        {
            if selectedInputUnit == 0 && selectedOutputUnit == 1
            {
                outputTxtValue = inputTxtValue - 273.15
            }
            else if selectedInputUnit == 0 && selectedOutputUnit == 2
            {
                outputTxtValue = (inputTxtValue * 1.8) - 459.67
            }
            else if selectedInputUnit == 1 && selectedOutputUnit == 0
            {
                outputTxtValue = inputTxtValue + 273.15
            }
            else if selectedInputUnit == 1 && selectedOutputUnit == 2
            {
                outputTxtValue = (inputTxtValue * 1.8) + 32
            }
            else if selectedInputUnit == 2 && selectedOutputUnit == 0
            {
                outputTxtValue = (inputTxtValue + 459.67) * 5/9
            }
            else if selectedInputUnit == 2 && selectedOutputUnit == 1
            {
                outputTxtValue = (inputTxtValue - 32)/1.8
            }
            lblOutputValue.text = String.init(format: "%.2f %@", outputTxtValue,arrTempUnits[selectedOutputUnit])
        }
        else if selectedUnitType == UnitType.Volume.rawValue
        {
            if selectedInputUnit == 0 && selectedOutputUnit == 1
            {
                outputTxtValue = inputTxtValue * 1000
            }
            else if selectedInputUnit == 0 && selectedOutputUnit == 2
            {
                outputTxtValue = inputTxtValue / 3.785411784
            }
            else if selectedInputUnit == 1 && selectedOutputUnit == 0
            {
                outputTxtValue = inputTxtValue/1000
            }
            else if selectedInputUnit == 1 && selectedOutputUnit == 2
            {
                outputTxtValue = inputTxtValue / 3.785411784 / 1000
            }
            else if selectedInputUnit == 2 && selectedOutputUnit == 0
            {
                outputTxtValue = inputTxtValue * 3.785411784
            }
            else if selectedInputUnit == 2 && selectedOutputUnit == 1
            {
                outputTxtValue = inputTxtValue * 3.785411784 * 1000
            }
            lblOutputValue.text = String.init(format: "%f %@", outputTxtValue,arrVolUnits[selectedOutputUnit])
        }
    }
    
    // MARK: - Textfield Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        strInputValue = textField.text!
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        strInputValue = textField.text!
    }
    
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        if string == "-"
        {
            if textField.text?.count == 0
            {
                return true
            }
            else
            {
                return false
            }
        }
        
        let numberDots = (textField.text?.components(separatedBy: ".").count)! - 1
        if numberDots > 0 && string == "."
        {
            return false
        }
        
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    // MARK: - common Alert Messages
    
    func showActionSheetWithValuesFrom(selectedType:Int, isInput:Bool)
    {
        var titleString = ""
        var itemString = ""
        var arrInputUnit:[String]? = nil
        if isInput
        {
            titleString = "Select input unit"
            itemString = "Input Unit"
        }
        else
        {
            titleString = "Select output unit"
            itemString = "Output Unit"
        }
        let alertView = UIAlertController(title: titleString, message: nil, preferredStyle: .actionSheet)
        switch selectedType {
        case UnitType.Temperature.rawValue:
            arrInputUnit = arrTempUnits
        case UnitType.Volume.rawValue :
            arrInputUnit = arrVolUnits
        default:
            break
        }
        for (index,item) in (arrInputUnit?.enumerated())!
        {
            let alertAction = UIAlertAction(title: item, style: .default) { (alertAction:UIAlertAction) in
                if isInput
                {
                    self.btnInputUnit.setTitle(String.init(format: "%@ : %@",itemString, item), for: .normal)
                    self.selectedInputUnit = index
                }
                else
                {
                    self.btnOutputUnit.setTitle(String.init(format: "%@ : %@",itemString, item), for: .normal)
                    self.selectedOutputUnit = index
                }
            }
            alertView.addAction(alertAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction:UIAlertAction) in
            alertView.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func showAlertWithMessage(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (alertAction:UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

