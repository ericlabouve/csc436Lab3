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
                var tempDict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:[String]]
                // Sort restaurants alphabetically
                for (city, _) in tempDict {
                    tempDict[city]!.sort()
                }
                return tempDict
            } catch {
                print(error)
            }
        }
        return [:]
    }()
    
    // Cities converted into an array so we can index dict later
    var cities: [String] = []
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var curOrdering: String = "<"
    
    func setMessageLabel() {
        let firstCompRow = pickerView.selectedRow(inComponent: 0)
        let secondCompRow = pickerView.selectedRow(inComponent: 1)
        let selectedCity = cities[firstCompRow]
        messageLabel.text = selectedCity + " - " + dict[selectedCity]![secondCompRow]
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Check if city changed
        if component == 0 {
            // Refresh the component with new restaurant labels
            pickerView.reloadComponent(1)
            // Set the selected row to the top
            pickerView.selectRow(0, inComponent: 1, animated: false)
        }
        setMessageLabel()
    }
    
    @IBAction func reverseOrdering(_ sender: UIButton) {
        var operation: (String, String) -> Bool
        if curOrdering == "<" {
            operation = (>)
            curOrdering = ">"
        } else {
            operation = (<)
            curOrdering = "<"
        }
        cities.sort(by: operation)
        for (city, _) in dict {
            dict[city]!.sort(by: operation)
        }
        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.selectRow(0, inComponent: 1, animated: false)
        pickerView.reloadComponent(0)
        pickerView.reloadComponent(1)
        setMessageLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = Array(dict.keys)
        cities.sort()
        setMessageLabel()
    }
}

