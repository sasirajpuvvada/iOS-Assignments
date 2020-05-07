//
//  Functionality.swift
//  Assignment3
//
//  Created by Sashi Raj on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation

class Functionality {
    var parentName = ""
    var childName = ""
    var flag = 0
    func add(_ pid: Int,_ cid: Int) -> Int {
        
        if !Node.dict.keys.contains(cid) && !Node.dict.keys.contains(pid) {
            
            print("Enter parents Name")
            if let tname =  readLine() { 
                parentName = tname
            } else{
                print("name not Entered")
            }
            print("Enter child's Name")
            
            if let tcname = readLine() {
                childName = tcname
            } else {
                print("name not Entered")
            }
            
            let pnode:Node = Node(pid,parentName)
            let cnode:Node = Node(cid,childName)
            pnode.frontNodes.append(cid)
            cnode.backNodes.append(pid)
            Node.dict[pnode.nodeId] = pnode
            Node.dict[cnode.nodeId] = cnode
            return 1
        }
        else if ( Node.dict.keys.contains(pid) && !Node.dict.keys.contains(cid) ) {
            print("Enter Child Name")
            if let tcname = readLine() {
                childName = tcname
            } else {
                print("Nme Not Entered")
            }
            let pnode:Node = Node.dict[pid]!
            let cnode:Node = Node(cid,childName)
            pnode.frontNodes.append(cid)
            cnode.backNodes.append(pid)
            Node.dict[cnode.nodeId] = cnode
            return 1
        }
        else if ( !Node.dict.keys.contains(pid) && Node.dict.keys.contains(cid) ) {
            print("Enter the parent Name")
            
            if let tname = readLine() {
                parentName = tname
            } else {
                print("Name Not Entered")
            }
            let pnode:Node = Node(pid,parentName)
            let cnode:Node = Node.dict[cid]!
            pnode.frontNodes.append(cid)
            cnode.backNodes.append(pid)
            Node.dict[pnode.nodeId] = pnode
            return 1
        }
        else {
            if((Node.dict[pid]!).frontNodes.contains(cid) && (Node.dict[cid]!).backNodes.contains(pid) )
            {
                print("dependecy Already Exists")
            }
            else {
                let check = CheckCycle()
                if check.cycle(pid, cid) == -1 {
                    print("Forming Cycle")
                    return -1
                }
                else {
                    (Node.dict[pid]!).frontNodes.append(cid)
                    (Node.dict[cid]!).backNodes.append(pid)
                    return 1
                }
            }
        }
      return flag
    }
    func getImmChildrean(_ cid: Int) {
        if(Node.dict.keys.contains(cid)) {
            let t = Node.dict[cid]!
            for node in t.frontNodes {
                print((Node.dict[node]!).nodeId , (Node.dict[node]!).name )
            }
        } else {
            print("Given id's Node not present in graph")
        }
    }
    
    func getImmParents(_ pid: Int) {
        if(Node.dict.keys.contains(pid)) {
            let t = Node.dict[pid]!
            for node in t.backNodes {
                  print((Node.dict[node]!).nodeId , (Node.dict[node]!).name )
            }
        } else {
            print("given id is not present in the graph")
        }
    }
    
    func  getAllAncestors(_ cid: Int){
        if Node.dict.keys.contains(cid) {
            let temp = Node.dict[cid]!
            print(temp.name,temp.nodeId)
            for node in temp.backNodes {
                getAllAncestors(node)
            }
        }
    }
    
    func getAllDescsendents(_ pid: Int) {
        if Node.dict.keys.contains(pid) {
            let temp = Node.dict[pid]!
            print(temp.name,temp.nodeId)
            for node in temp.frontNodes {
                getAllDescsendents(node)
            }
        }
    }
    
    func  deleteNode(_ pid: Int) {
        let temp = Node.dict[pid]!
        for node in temp.frontNodes {
            deleteNode(node)
        }
        temp.backNodes.removeAll()
        temp.frontNodes.removeAll()
        Node.dict.removeValue(forKey: temp.nodeId)
    }
}
