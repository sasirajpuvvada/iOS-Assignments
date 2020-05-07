//
//  Sorting.swift
//  Assignment2
//
//  Created by Sashi Raj on 28/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
class Sorting  {
    func choice()
    {
        let k = ErrorHandling()
        var instStudent = k.getStudentInst()
        print("1. sort using rollno")
        print("2. sort using name")
        print("3. sort using age")
        print("4. sort using address")
        print("5. sort using rollno (DESC)")
        print("6. sort using name (DESC)")
        print("7. sort using age (DESC)")
        print("8. sort using address (DESC)")
        if let k = readLine() {
            if let p = Int(k), p<9 {
                switch p {
                case 1: instStudent.sort(by: {($0.getRollNo() < $1.getRollNo())})
                case 2: instStudent.sort(by: {($0.studentName < $1.studentName)})
                case 3: instStudent.sort(by: {($0.getAge() < $1.getAge())})
                case 4: instStudent.sort(by: {($0.getAddress() < $1.getAddress())})
                case 5: instStudent.sort(by: {($0.getRollNo() > $1.getRollNo())})
                case 6: instStudent.sort(by: {($0.getName() > $1.getName())})
                case 7: instStudent.sort(by: {($0.getAge() > $1.getAge())})
                case 8: instStudent.sort(by: {($0.getAddress() > $1.getAddress())})
                default: print("Wrong Input")
                }
            } else {
                print("Wrong Input")
            }
        }
        for val in instStudent{
        print(val.getName(), val.getAddress(), val.getAge(), val.getCourses(), val.getRollNo())
            }
    }
}
