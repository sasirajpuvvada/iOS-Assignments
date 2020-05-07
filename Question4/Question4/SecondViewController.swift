//
//  SecondViewController.swift
//  Question4
//
//  Created by Sasi Raj on 04/02/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        display()
        // Do any additional setup after loading the view.
    }
    
    func display()  {
        lblName.text = "Name= "+TableViewController.name
        lblPrice.text = "Price= "+String(TableViewController.price)
        lblQuantity.text = "Quantity= "+String(TableViewController.quantity)
        lblType.text = "Type= "+TableViewController.type
        lblTax.text = "Tax= "+String(calTax())
    }
    func calTax() -> Double{
        let price = TableViewController.price
        let quantity = TableViewController.quantity
        let tax = (price * Double(quantity))
        return tax
    }
}
