//
//  ErrorHandling.swift
//  Assignment2
//
//  Created by Sashi Raj on 28/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
var stu = [Student]()
var instImpl = Implemtation()
class ErrorHandling {
    func getStudentInst() -> [Student] {
        return stu
    }
    func errorCheck() {
        do{
            let inst = try instImpl.addDetails(stu)
            let a = Student(inst[0] as! String,inst[1] as! String,inst[2] as! Int,inst[3] as! Set<String>,inst[4] as! Int)
            stu.append(a)
        } catch Errors.noinput {
            print("You have not ginven any input")
        } catch Errors.nonString {
            print("Value should not be String")
        } catch Errors.nonInteger {
            print("value should not be Integer")
        } catch Errors.invalidType {
            print("Not a Valid Type")
        } catch{
            print("cannot take the Input")
        }
    }
}
