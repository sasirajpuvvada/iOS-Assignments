//
//  ErrorChecking.swift
//  Assignment1
//
//  Created by Sashi Raj on 27/01/20.
//  Copyright © 2020 Sashi Raj. All rights reserved.
//

import Foundation

class Parser {
    var item = [Any]()
    var types = ["raw","imported","manufacctured"]
    func check_items() throws -> [Any] {
        
        print("Enter Item's name")
        guard let tname = readLine() else {
            throw Errors.noinput
        }
        let name = tname
        item.append(name)
        
        print("Enter the price of the item")
        guard let tprice = readLine() else {
            throw Errors.noinput
        }
        guard Double(tprice) != nil else {
            throw Errors.nonDouble
        }
        
        let price = Double(tprice)
        item.append(price ?? 0)
        
        print("Enter item Quantity")
        
        guard let tquantity = readLine() else {
            throw Errors.noinput
        }
        
        guard Int(tquantity) != nil else {
            throw Errors.nonInteger
        }
        
        let quantity = Int(tquantity)
        item.append(quantity ?? 0)
        
        print("Enter type of item")
        print("Avaiable types \(types)")
        
        guard let ttype = readLine() else {
            throw Errors.noinput
        }
        guard types.contains(ttype) else {
            throw Errors.notValidType
        }
        let type = ttype
        item.append(type)
        print(item)
        return item
    }
}
