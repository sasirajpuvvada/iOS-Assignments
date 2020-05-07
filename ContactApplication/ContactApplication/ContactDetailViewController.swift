//
//  ContactDetailViewController.swift
//  ContactApplication
//
//  Created by Sasi Raj on 06/02/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblComapny: UILabel!
    var contact: Contact? = nil
    var isDeleted: Bool = false
    var index: IndexPath? = nil
    @IBOutlet weak var imageField: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
    }
    
    func display() {
        lblName.text = contact?.name
        lblPhone.text = contact?.phone
        lblEmail.text = contact?.email
        lblComapny.text = contact?.company
        loadImageFromDiskWith(fileName: lblName.text!+".png")
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
    
    @IBAction func btnDone(_ sender: Any) {
        performSegue(withIdentifier: "unwindContactList", sender: self)    }
    
    
    @IBAction func btnDelete(_ sender: Any) {
        isDeleted = true
        performSegue(withIdentifier: "unwindContactList", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editContact" {
            guard let viewController = segue.destination as? ContactViewController else {
                return
            }
            viewController.titleText = "Edit Contact"
            viewController.contact = contact
            viewController.index = self.index
        }
    }
}
