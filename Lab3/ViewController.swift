//
//  ViewController.swift
//  Lab3
//
//  Created by Eric LaBouve on 1/23/19.
//  Copyright © 2019 Eric LaBouve. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var dict: [String:[String]] = {
        if let url = Bundle.main.url(forResource:"Restaurants", withExtension:"plist") {
            do {
                let data = try Data(contentsOf:url)
                let tempDict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:[String]]
            } catch {
                print(error)
            }
        }
        return [:]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        <#code#>
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        <#code#>
    }

}

