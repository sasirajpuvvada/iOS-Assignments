//
//  CheckCycle.swift
//  Assignment3
//
//  Created by Sashi Raj on 29/01/20.
//  Copyright © 2020 Nuclei. All rights reserved.
//

import Foundation
class CheckCycle {
    var fPid = Set<Int> ()
    var bPid = Set<Int> ()
    var flag:Bool = false
    
    func cycle(_ pid: Int,_ cid: Int) -> Int {
        fPid.removeAll()
        bPid.removeAll()
        var request = 1
        getAncestors(pid,request)
        flag = false
        request = 2
        getAncestors(cid,request)
        if(flag == true || bPid.contains(pid) || bPid.contains(cid))
        {
            return -1
        }
        request = 1
        getDescendents(pid, request)
        request = 2
        getDescendents(cid, request)
        if (flag == true || fPid.contains(pid)) || fPid.contains(cid) {
            return -1
        }
        
        return 1
    }
    
    func findAllAncestors(_ node: Int,_ request: Int) {
        if request == 1 {
            bPid.insert(node)
        } else {
            if bPid.contains(node) {
                flag = true
                return
            }
        }
        for eachNode in (Node.dict[node]!).backNodes {
        findAllAncestors(eachNode,request)
        }
    }
    
    func getAncestors(_ node: Int,_ request: Int) {
        for eachNode in (Node.dict[node]!).backNodes {
            findAllAncestors(eachNode,request)
        }
    }
    
    func findAllDescendents(_ node: Int,_ request: Int) {
        if request == 1 {
            fPid.insert(node)
        } else {
            if fPid.contains(node) {
                flag = true
                return
            }
        }
        for eachNode in (Node.dict[node]!).frontNodes {
            findAllDescendents(eachNode, request)
        }
    }
    
    func getDescendents(_ node: Int,_ request: Int) {
        for eachNode in (Node.dict[node]!).frontNodes {
            findAllDescendents(eachNode, request)
        }
    }
    
    
}
