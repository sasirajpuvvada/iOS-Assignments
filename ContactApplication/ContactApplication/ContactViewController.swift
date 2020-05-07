//
//  ContactViewController.swift
//  ContactApplication
//
//  Created by Sasi Raj on 06/02/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCompany: UITextField!
    
    var titleText = "add Contact"
    var contact : Contact? = nil
    var index: IndexPath? = nil
    
    var imagePickerController: UIImagePickerController!
    @IBOutlet weak var lblTitleText: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblPhoneError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblCompanyError: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        txtName.delegate = self
        txtPhone.delegate = self
        txtEmail.delegate = self
        txtCompany.delegate = self
        txtName.keyboardType = UIKeyboardType.asciiCapable
        txtPhone.keyboardType = UIKeyboardType.phonePad
        txtEmail.keyboardType = UIKeyboardType.emailAddress
        txtCompany.keyboardType = UIKeyboardType.asciiCapable
        lblPhoneError.textColor = UIColor.red
        lblEmailError.textColor = UIColor.red
        lblNameError.textColor = UIColor.red
        lblCompanyError.textColor = UIColor.red
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let charactersAllowed = CharacterSet.punctuationCharacters
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let phoneRegEx = "[0-9]{10}"
        if textField == txtName {
            if txtName.text == "" {
                lblNameError.text = "Name Should Not be Empty"
            } else {
                lblNameError.text = ""
            }
            if txtName.text!.count > 10 {
                return false
            }
        }
        else if textField == txtCompany {
            if txtName.text == "" {
                lblCompanyError.text = "company Should Not be Empty"
                return false
            } else if txtCompany.text!.count > 10 {
                return false
            } else {
                lblCompanyError.text = ""
            }
        }
        
        else if textField == txtEmail {
            if txtEmail.text == "" {
                lblEmailError.text = "Email Should Not be Empty"
//                return false
            } else if txtEmail.text != emailRegEx {
                lblEmailError.text = "Error in Email"
//                return false
            } else if txtEmail.text != emailRegEx {
                lblEmailError.text = "email is in incorrect format"
//                return false
            } else {
                lblEmailError.text = ""
            }
        }
        else if textField == txtPhone {
            if txtPhone.text == "" {
                lblPhoneError.text = "Phone should not be Empty"
            } else if txtPhone.text != phoneRegEx {
                lblPhoneError.text = "phone should contain at 10 digits"
            } else {
                lblPhoneError.text = ""
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        lblTitleText.text = titleText
        if let varContact = contact {
            txtName.text = varContact.name
            txtPhone.text = varContact.phone
            txtEmail.text = varContact.email
            txtCompany.text = varContact.company
            loadImageFromDiskWith(fileName: txtName.text!+".png")
        }
        super.viewDidLoad()
    }

    @IBAction func btnSave(_ sender: Any) {
        saveImage(imageName: txtName.text!+".png", image: imageField.image!)
        performSegue(withIdentifier: "unwindContactList", sender: self)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        txtName.text = ""
        txtPhone.text = ""
        txtEmail.text = ""
        txtCompany.text = ""
        performSegue(withIdentifier: "unwindContactList", sender: self)
    }
    
    @IBAction func addImage(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .savedPhotosAlbum
        present(imagePickerController,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        imageField.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
    func saveImage(imageName: String, image: UIImage) {
     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
      let fileName = imageName
      var fileURL = documentsDirectory.appendingPathComponent(fileName)
      guard let data = image.jpegData(compressionQuality: 1) else { return }
      if FileManager.default.fileExists(atPath: fileURL.path) {
        do {
          try FileManager.default.removeItem(atPath: fileURL.path)
        }catch let removeError {
          print("couldn't remove file at path", removeError)
        }
      }
      do{
        try data.write(to: fileURL)
      }catch {
        fileURL = documentsDirectory.appendingPathComponent(fileName.lowercased())
        do{
          try data.write(to: fileURL)
        }
        catch let error1 {
          print(error1)
        }
      }
    }
    
    func loadImageFromDiskWith(fileName: String){
      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
      let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
      let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
      if let dirPath = paths.first {
        let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: imageUrl.path)
        if image != nil{
          imageField.image = image
        }
        else{
          let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName.lowercased())
          let image = UIImage(contentsOfFile: imageUrl.path)
          if image != nil{
            imageField.image = image
          }
        }
      }
      else{
        print(fileName,"doesn't exist")
      }
    }
    

}
