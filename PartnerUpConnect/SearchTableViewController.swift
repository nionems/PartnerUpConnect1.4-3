//
//  SearchTableViewController.swift
//  PartnerUpConnect
//
//  Created by lionel coevoet on 12/11/2022.
//

import UIKit

class SearchTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let service = FirestoreRepository()
    var searchFrom : String = ""
    var locationQuery : String = ""
    var pickerLevelData: [String] = [String]()
    var pickerGenderData: [String] = [String]()
    var filter : String = ""
    
    @IBOutlet weak var searchByLocation: UITextField!
    @IBOutlet weak var levelPicker: UIPickerView!
    @IBOutlet weak var genderPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialise the picker
        self.levelPicker.delegate = self
        self.levelPicker.dataSource = self
        
        self.genderPicker.delegate = self
        self.genderPicker.dataSource = self
        
        pickerLevelData = ["A", "B", "C", "D", "E", "F", "G" ]
        pickerGenderData = ["Male", "Female"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var totalRows : Int = pickerLevelData.count
        if pickerView == self.genderPicker {
            totalRows = self.pickerGenderData.count
        }
        return totalRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == levelPicker {
            return pickerLevelData[row]
        }else if pickerView == genderPicker{
            return pickerGenderData[row]
        }
        return ""
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == levelPicker {
            self.filter = pickerLevelData[row]
        }else if pickerView == genderPicker{
            self.filter = pickerGenderData[row]
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let contactTableVC = segue.destination as? ContactsTableViewController{
            if segue.identifier == "searchByLevelSegue"{
                contactTableVC.searchFrom = "searchByLevel"
                contactTableVC.levelQuery = self.filter
            }else if segue.identifier == "searchByLocaltionSegue"{
                contactTableVC.searchFrom = "searchByLocation"
                contactTableVC.locationQuery = searchByLocation.text!
            }else if segue.identifier == "searchByGenderSegue"{
                contactTableVC.searchFrom = "searchByGender"
                contactTableVC.genderQuery = self.filter
            }
        }
    }
}
