//
//  main.swift
//  Assignment3
//
//  Created by Sashi Raj on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
var op = "y"
let graph = Functionality()
var pid = 0, cid = 0
func addDependency() {
    print("Enter ParentId")
    if let res = Int(readLine()!) , res > 0 {
        pid = res
    } else {
        print("Invalid Entry")
    }
    print("Enter ChilderenId")
    if let res1 = Int(readLine()!) , res1 > 0 {
        cid = res1
    } else {
        print("Invalid Entry")
    }
    if graph.add(pid, cid) == 1 {
        print("Dependecy Added Successfully")
    }
    else {
        print("Could not add Dependency")
    }

}

func immediateChildren() {
    print("Enter the node you want children of")
    if let res = Int(readLine()!) {
        pid = res
        graph.getImmChildrean(pid)
    } else {
        print("plese Enter valid values")
    }
}

func immediateParent() {
    print("Enter the node you want parents of")
    if let res = Int(readLine()!) {
        cid = res
        graph.getImmParents(cid)
    } else {
        print("plese Enter valid values")
    }
}
func getAllAncestors() {
    print("Enter The node id you want to ancestors of")
    if let res = Int(readLine()!) {
        cid = res
        graph.getAllAncestors(cid)
    }
}

func getAllDescendants() {
    print("Enter The node id you want descendants of")
    if let res = Int(readLine()!) {
        pid = res
        graph.getAllDescsendents(pid)
    }
}
func deleteNode() {
    print("Enter The node id of the node which you want to delete")
    if let res = Int(readLine()!) {
        pid = res
        if Node.dict.keys.contains(pid) {
            let temp:Node = Node.dict[pid]!
            if temp.backNodes.count == 0{
                graph.deleteNode(pid)                  // if node does not have parent
            } else if temp.frontNodes.count == 0 {
                for node in temp.backNodes {
                    (Node.dict[node]!).frontNodes.removeAll{$0 == pid}   // if node does not have children
                }
                temp.backNodes.removeAll()
                temp.backNodes.removeAll()
            } else {
                for node in temp.backNodes {
                     (Node.dict[node]!).frontNodes.removeAll{$0 == pid}
                }
                graph.deleteNode(pid)
            }
        } else {
            print(" This ID is not present in the Graph")
        }
    }
}

repeat {
    print("1. Add dependency")
    print("2. print Immediate Children")
    print("3. print Immediate Parents")
    print("4. print all Ancestors")
    print("5. print all Descendants")
    print("6. Delete Nodes")
    print("Enter Your Option")
    if let choice1 = readLine() {
        if let choice = Int(choice1){
            switch  choice {
            case 1: addDependency()
            case 2: immediateChildren()
            case 3: immediateParent()
            case 4: getAllAncestors()
            case 5: getAllDescendants()
            case 6: deleteNode()
            case 7: print("Exit")
                    op = "n"
            default: op = "n"
            }
        } else {
            print("you have Entered non Integer Value")
        }
    }
    
}while(op == "y")
