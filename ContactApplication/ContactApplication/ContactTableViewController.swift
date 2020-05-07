//
//  ContactTableViewController.swift
//  ContactApplication
//
//  Created by Sasi Raj on 06/02/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    
    var contact: [Contact] = []
    var sortedFirstLetter: [String] = []
    var sections: [[Contact]] = [[]]
    
    
    override func viewWillAppear(_ animated: Bool) {
        let firstLetters = contact.map({$0.titleFirstLetter})
        let uniqueLetters = Array(Set(firstLetters))
        sortedFirstLetter = uniqueLetters.sorted()
        sections = sortedFirstLetter.map {firstLetters in return contact .filter {$0.titleFirstLetter == firstLetters}
            .sorted {$0.name < $1.name}
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
////        let c = Contact(name: "sasi", phone: "84998", email: "sasi", company: "Nulei")
////        contact.append(c)
        
    }
    
    func load() {
        let firstLetters = contact.map({$0.titleFirstLetter})
        let uniqueLetters = Array(Set(firstLetters))
        sortedFirstLetter = uniqueLetters.sorted()
        sections = sortedFirstLetter.map {firstLetters in return contact .filter {$0.titleFirstLetter == firstLetters}
                    .sorted {$0.name < $1.name}
            }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedFirstLetter[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let names = sections[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        cell.textLabel?.text = names.name
        
        return cell
    }
    
    @IBAction func unwindContactList(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? ContactViewController {
            let name = viewController.txtName.text
            let phone = viewController.txtPhone.text
            let email = viewController.txtEmail.text
            let company = viewController.txtCompany.text
            let varContact = Contact(name: name!, phone: phone!, email: email!, company: company!)
            if let indexPath = viewController.index  {
                let sec = indexPath.section
                let row = indexPath.row
                let value = sections[sec][row]
                var c = 0
                for data in contact {
                    if data.email == value.email {
                        contact[c] = varContact
                        break
                    } else if data.phone == value.phone {
                        contact[c] = varContact
                    }
                    c = c + 1
                }
                load()
            } else {
                contact.append(varContact)
                load()
            }
        } else if let viewController = segue.source as? ContactDetailViewController {
            if viewController.isDeleted {
                guard let indexPath = viewController.index else { return }
                let section = indexPath.section
                let row = indexPath.row
                let a = sections[section][row]
               // print(a)
                var c = 0
                for data in contact {
                    if data.name == a.name {
                        contact.remove(at: c)
                    }
                    c = c + 1
                }
                load()
            }
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactDetailSegue" {
            let viewController = segue.destination as! ContactDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            guard let row = indexPath?.row else { return }
            guard let sec = indexPath?.section else { return }
            print("sec= ",sec,"row = ",row)
            let varContact = sections[sec][row]
            viewController.contact = varContact
            viewController.index = indexPath
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */



}
