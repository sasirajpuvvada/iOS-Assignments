//
//  TableViewController.swift
//  Question4
//  Created by Sasi Raj on 04/02/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    @IBOutlet var tabView: UITableView!
    var item : [NSManagedObject] = []
    static var name = ""
    static var price: Double = 0.0
    static var quantity = 0
    static var type = ""
    
  //  static let helper = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as! AppDelegate? else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Items")
        
        do {
            self.item = try managedContext.fetch(fetchRequest)
           // print(item[0].value(forKey: "name") as! String)
        } catch {
            print("couldn't Fetch the data")
        }
        tabView.reloadData()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return item.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //    print("abcde")
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let tempItem = item[indexPath.row]
        cell.textLabel?.text = (tempItem.value(forKey: "name") as! String)
     //   print(tempItem.value(forKey: "name"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TableViewController.name = item[indexPath.row].value(forKey: "name") as! String
        TableViewController.price = item[indexPath.row].value(forKey: "price") as! Double
        TableViewController.quantity = item[indexPath.row].value(forKey: "quantity") as! Int
        TableViewController.type = item[indexPath.row].value(forKey: "type") as! String
        //print(name,price,quantity,type)
        let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}
