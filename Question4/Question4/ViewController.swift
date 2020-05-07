//
//  ViewController.swift
//  Question4
//
//  Created by Sasi Raj on 03/02/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    var name: String = ""
    var price: Double = 0.0
    var quantity: Int64 = 0
    var type: String = ""
    
    @IBOutlet weak var lblErrorName: UILabel!
    @IBOutlet weak var lblErrorPrice: UILabel!
    @IBOutlet weak var lblErrorQuantity: UILabel!
    @IBOutlet weak var lblErrorType: UILabel!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    @IBOutlet weak var txtType: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblErrorName.textColor = UIColor.red
        lblErrorPrice.textColor = UIColor.red
        lblErrorQuantity.textColor = UIColor.red
        lblErrorType.textColor = UIColor.red
        txtName.keyboardType = UIKeyboardType.asciiCapable
        txtPrice.keyboardType = UIKeyboardType.decimalPad
        txtQuantity.keyboardType = UIKeyboardType.phonePad
        txtType.keyboardType = UIKeyboardType.asciiCapable
        txtName.addTarget(self, action: #selector(checkAndDisplayError(textField:)), for: .editingChanged)
        txtPrice.addTarget(self, action: #selector(checkAndDisplayErrorPrice(textField:)), for: .editingChanged)
        txtQuantity.addTarget(self, action: #selector(checkAndDisplayErrorQuantity(textField:)), for: .editingChanged)
        txtType.addTarget(self, action: #selector(checkAndDisplayErrorType(textField:)), for: .editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {  // keyboard pops up on
        super.viewDidAppear(animated)                   //clicking textfiled
        txtName.delegate = self
        txtPrice.delegate = self
        txtQuantity.delegate = self
        txtType.delegate = self
        txtName.becomeFirstResponder()
        txtPrice.becomeFirstResponder()
        txtQuantity.becomeFirstResponder()
        txtType.becomeFirstResponder()
    }
    
    @objc func checkAndDisplayError(textField: UITextField) {
        if (textField.text == ""){
            lblErrorName.text = "Item name should not be empty"
        } else if (textField.text?.count ?? 0 >= 6) {
            lblErrorName.text = "Item Name Should not be more than 6 character"
        } else {
            lblErrorName.text = ""
        }
    }
    @objc func checkAndDisplayErrorType(textField: UITextField) {
        if (textField.text == ""){
            lblErrorType.text = "Item type should not be empty"
        } else if (textField.text?.count ?? 0 >= 8) {
            lblErrorType.text = "Item type Should not be more than 6 charcahters"
        } else {
            lblErrorType.text = ""
        }
    }
    @objc func checkAndDisplayErrorPrice(textField: UITextField) {
        if (textField.text == ""){
            lblErrorPrice.text = " Price should not be empty"
        } else {
            lblErrorPrice.text = ""
        }
    }
    @objc func checkAndDisplayErrorQuantity(textField: UITextField) {
        if (textField.text == ""){
            lblErrorQuantity.text = " Quantity should not be empty"
        } else {
            lblErrorQuantity.text = ""
        }
    }
    
    @IBAction func btnSave(_ sender: Any) {
    
        if let tName = txtName.text {
            if tName == "" {
                showAlert(alert: "Name is Empty")
                txtName.text = ""
                return
            }
            name = tName
        }

        if let tPrice = txtPrice.text {
            if tPrice == "" {
                showAlert(alert: "Price Is Empty")
                txtPrice.text = ""
                return
            } else if let tPrice1 = Double(tPrice) , tPrice1 >= 0 {
                price = tPrice1

            } else {
                showAlert(alert: "Price must be Double and positive")
                txtPrice.text = ""
                return
            }
        }

        if let tQuantity = txtQuantity.text {
            if tQuantity == "" {
                showAlert(alert: "Quantity is Empty")
                txtQuantity.text = ""
                return
            } else if let tQuantity1 = Int(tQuantity), tQuantity1 > 0 {
                quantity = Int64(tQuantity1)
            } else {
                showAlert(alert: "Price must be Integer and positive")
                txtPrice.text = ""
                return
            }
        }

        if let tType = txtType.text {
            if tType == "" {
                showAlert(alert: "Type Musr Not be Empty")
                txtType.text = ""
                return
            }
            type = tType
        }
    //    print("abcd")
        saveData(name: name, price: price, quantity: quantity, type: type)
        
    }
    
    func saveData(name: String,price: Double,quantity: Int64,type: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate? else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Items", in: managedContext)!
       
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        
        item.setValue(name, forKeyPath: "name")
        item.setValue(price, forKeyPath: "price")
        item.setValue(quantity, forKeyPath: "quantity")
        item.setValue(type, forKeyPath: "type")
        
        do {
            try managedContext.save()
            txtName.text = ""
            txtPrice.text = ""
            txtQuantity.text = ""
            txtType.text = ""
        } catch {
            print("Couldn't Save The Items")
        }
    }
    
    func showAlert(alert: String) {
        let alert = UIAlertController(title: "Error", message: alert, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnShow(_ sender: Any) {
        let tableViewController = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtName.endEditing(true)    // hides keyboard when pressed outside texfields
        txtPrice.endEditing(true)
        txtQuantity.endEditing(true)
        txtType.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // hides keyboard
        textField.resignFirstResponder()             // when return is pressed
        return true
    }

}
