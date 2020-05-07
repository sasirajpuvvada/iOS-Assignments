//
//  Contact.swift
//  ContactApplication
//
//  Created by Sasi Raj on 06/02/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
struct Contact {
    let name: String
    let phone:  String
    let email: String
    let company: String
    
    var titleFirstLetter: String {
        return String(self.name[self.name.startIndex]).uppercased()
    }
    
}
