//
//  FirestoreGroupMock.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 13/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
@testable import SwimCoach

class FirestoreGroupMock: NetworkGroupService {
    
    var groups: [Group]
    let error: Error?
    
    let emptyGroup = [Group]()
    
    init(groups: [Group], error: Error? = nil){
        self.groups = groups
        self.error = error
    }
    
    func fetchGroup(completion: @escaping ([Group], Error?) -> ()) {
        if self.error == nil {
            completion(self.groups, nil)
        }
        else {
            completion(emptyGroup, error)
        }
    }
    
    func addGroup(group: Group) {
        groups.append(group)
    }
    
    func deleteGroup(group: Group) {
        var index = 0
        
        for groupTest in groups {
            if groupTest.groupName == group.groupName {
                groups.remove(at: index)
                return
            }
            index += 1
        }
    }
    
}
