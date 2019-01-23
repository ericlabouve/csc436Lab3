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
                return tempDict
            } catch {
                print(error)
            }
        }
        return [:]
    }()
    
    // Cities converted into an array so we can index dict later
    var cities: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = Array(dict.keys)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dict.count
        }
        else if component == 1 {
            // Get the string value from the current row in the first component
            let cityIdx = pickerView.selectedRow(inComponent: 0)
            let cityName = cities[cityIdx]
            // Get the length the array pointed to by dict[key]
            return (dict[cityName]?.count)!
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return cities[row]
        }
        else if component == 1 {
            let cityIdx = pickerView.selectedRow(inComponent: 0)
            let cityName = cities[cityIdx]
            return dict[cityName]![row]
        }
        return "!!!"
    }

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        <#code#>
//    }

}

