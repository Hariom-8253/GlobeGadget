//
//  AddressFormViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 18/07/25.
//

import UIKit

class AddressFormViewController: UIViewController {
    
    var selectedState: String?
    var selectedCity: String?
    var isSelectingState = true
    
    let stateList = Address.stateList
    var cityList: [String] = []
    let pickerView = UIPickerView()
    
    var objAddress : Address?
    
    @IBOutlet weak var cityPicker: UIPickerView!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var btnSubmitAddForm: UIButton!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var txtAdd2: UITextField!
    @IBOutlet weak var txtAdd1: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtState.inputView = pickerView
        txtCity.inputView = pickerView
        
        
        let allTextFields = [txtDob!,txtAdd1!,txtAdd2!, txtCity!, txtState!, txtEmail!, txtPincode!, txtLastName!, txtMobileNo!, txtFirstName!]
        let allbuttons = [btnSubmitAddForm!]
        let allViews = allbuttons + allTextFields
        
        styleViews(allViews, cornerRadius: 8, borderWidth: 1, borderColor: UIColor.colorPrimary.cgColor)
        setPaddingForTextFields(allTextFields, left: 10, right: 10)
        
        self.title = "Add Address"
        
        if let obj = objAddress {
            self.title = "Edit Address"
            btnSubmitAddForm.setTitle("Update", for: .normal)
            
            txtFirstName.text = obj.strFirstName
            txtLastName.text = obj.strLastName
            txtEmail.text = obj.strEmail
            txtState.text = obj.strState
            txtCity.text = obj.strCity
            txtPincode.text = "\(obj.intPincode ?? 0)"
            txtDob.text = "\(obj.intAge ?? 0)"
            txtAdd1.text = obj.strAddress1
            txtAdd2.text = obj.strAddress2
            txtMobileNo.text = "\(obj.intMobileNo ?? 0)"
            
            if let state = obj.strState {
                cityList = Address.cities(forState: state)
            }
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        let firstName = txtFirstName.text ?? ""
        let lastName = txtLastName.text ?? ""
        let email = txtEmail.text ?? ""
        let mobile = txtMobileNo.text ?? ""
        let dob = txtDob.text ?? ""
        let state = txtState.text ?? ""
        let city = txtCity.text ?? ""
        let address1 = txtAdd1.text ?? ""
        let address2 = txtAdd2.text ?? ""
        let pincode = txtPincode.text ?? ""
        
        switch true {
        case firstName.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your first name.", viewController: self)
            return
        case lastName.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your last name.", viewController: self)
            return
        case email.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your email.", viewController: self)
            return
        case mobile.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your mobile number.", viewController: self)
            return
        case dob.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your age.", viewController: self)
            return
        case state.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your state.", viewController: self)
            return
        case city.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your city.", viewController: self)
            return
        case address1.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter address line 1.", viewController: self)
            return
        case address2.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter address line 1.", viewController: self)
            return
        case pincode.isEmpty:
            UIAlertController.showAlert(title: "Error", message: "Please enter your pincode.", viewController: self)
            return
        default:
            break
        }
        
        if let obj = objAddress {
            
            obj.strFirstName = txtFirstName.text ?? ""
            obj.strLastName = txtLastName.text ?? ""
            obj.strEmail = txtEmail.text ?? ""
            obj.intMobileNo = Int(txtMobileNo.text ?? "0") ?? 0
            obj.intAge = Int(txtDob.text ?? "0") ?? 0
            obj.strState = txtState.text ?? ""
            obj.strCity = txtCity.text ?? ""
            obj.strAddress1 = txtAdd1.text ?? ""
            obj.strAddress2 = txtAdd2.text ?? ""
            obj.intPincode = Int(txtPincode.text ?? "0") ?? 0
            
        }
        
        else {
            
            let objAddress = Address(
                strFirstName: txtFirstName.text ?? "",
                strLastName: txtLastName.text ?? "",
                strEmail: txtEmail.text ?? "",
                intAge: Int(txtDob.text ?? "") ?? 0,
                strState: txtState.text ?? "",
                strCity: txtCity.text ?? "",
                strAddress1: txtAdd1.text ?? "",
                strAddress2: txtAdd2.text ?? "",
                intPincode: Int(txtPincode.text ?? "") ?? 0,
                intMobileNo: Int(txtMobileNo.text ?? "") ?? 0
            )
            arrAddressList.append(objAddress)
            
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
