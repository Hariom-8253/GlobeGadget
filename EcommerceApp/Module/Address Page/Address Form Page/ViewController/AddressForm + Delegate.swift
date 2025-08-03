//
//  AddressForm + Delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 30/07/25.
//

import Foundation
import UIKit

extension AddressFormViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtState {
            isSelectingState = true
            pickerView.reloadAllComponents()
            if let selectedState = txtState.text,
               let index = stateList.firstIndex(of: selectedState) {
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
        } else if textField == txtCity {
            isSelectingState = false
            if txtState.text?.isEmpty ?? true {
                UIAlertController.showAlert(title: "Error", message: "Please select a state first.", viewController: self)
                textField.resignFirstResponder()
            } else {
                cityPicker.reloadAllComponents()
                if let selectedCity = txtCity.text,
                   let index = cityList.firstIndex(of: selectedCity) {
                    pickerView.selectRow(index, inComponent: 0, animated: false)
                }
            }
        }
    }
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtFirstName && textField.returnKeyType == .next{
            txtFirstName.resignFirstResponder()
            txtLastName.becomeFirstResponder()
        }
        else if textField == txtLastName && textField.returnKeyType == .next{
            txtLastName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail && textField.returnKeyType == .next{
            txtEmail.resignFirstResponder()
            txtMobileNo.becomeFirstResponder()
        }
        else if textField == txtMobileNo && textField.returnKeyType == .next{
            txtMobileNo.resignFirstResponder()
            txtDob.becomeFirstResponder()
        }
        else if textField == txtDob && textField.returnKeyType == .next{
            txtDob.resignFirstResponder()
            txtState.becomeFirstResponder()
        }
        else if textField == txtState && textField.returnKeyType == .next{
            txtState.resignFirstResponder()
            txtCity.becomeFirstResponder()
        }
        else if textField == txtCity && textField.returnKeyType == .next{
            txtCity.resignFirstResponder()
            txtAdd1.becomeFirstResponder()
        }
        else if textField == txtAdd1 && textField.returnKeyType == .next{
            txtAdd1.resignFirstResponder()
            txtAdd2.becomeFirstResponder()
        }
        else if textField == txtAdd2 && textField.returnKeyType == .next{
            txtAdd2.resignFirstResponder()
            txtPincode.becomeFirstResponder()
        }
        else{
            txtPincode.resignFirstResponder()
        }
        return true
    }
}

extension AddressFormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isSelectingState ? stateList.count : cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return isSelectingState ? stateList[row] : cityList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isSelectingState {
            selectedState = stateList[row]
            txtState.text = selectedState
            
            // Load cities for the selected state
            cityList = Address.cities(forState: selectedState!)
            txtCity.text = "" // reset city if state changes
            txtCity.isUserInteractionEnabled = true
        } else {
            selectedCity = cityList[row]
            txtCity.text = selectedCity
        }
    }
}
