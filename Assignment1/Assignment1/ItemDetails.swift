//
//  ItemDetails.swift
//  Assignment1
//
//  Created by Sashi Raj on 27/01/20.
//  Copyright © 2020 Sashi Raj. All rights reserved.
//

import Foundation
var allItems = [Any]()
class ItemDetails{
    var item_name: String = ""
    var item_price: Double = 0.0
    var item_quantity: Int = 0
    var item_type: String = ""
    var item_tax: Double = 0.0
    init(_ item_name: String,_ item_price: Double,_ item_quantity: Int, _ item_type: String){
        
        self.item_name = item_name
        self.item_price = item_price
        self.item_quantity = item_quantity
        self.item_type = item_type
    }
    
    func calculateTax()  {
        if item_type == "raw" {
            item_tax = 0.125 * (item_price * Double(item_quantity))
        }
        else if item_type == "manufactured" {
            item_tax = 0.125 * (item_price * Double(item_quantity))
            item_tax += 0.02 * ((Double(item_quantity) * item_price) + 0.125 * (item_price * Double(item_quantity)))
        }
        else {
            item_tax = 0.1 * (Double(item_quantity) * item_price)
            if (item_tax<100)
            {
                item_tax += 5
            }
            else if (item_tax<200)
            {
                item_tax += 10
            }
            else
            {
                item_tax += 0.05 * (item_price * Double(item_quantity))
            }
        }
    }
    
}
