//
//  HomeScreenViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 16/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine

final class HomeScreenViewModel {
    
    // This publisher is for the activity wheel
    @Published var isLoading: Bool = false
    
    // This publisher is used as a signal of new available data
    @Published var dataAvaillable: Bool = false
    
    var groups: [Group]?
    
    /// Fetch data from FireStore and updates the publisher to signal there is data availlable
    ///
    /// In this function we change the value of our publisher to update the UI in the view controller
    func fetchGroup() {
        isLoading = true
        FirestoreGroupManager.fetchGroupe { (groups, error) in
            if error != nil {
                print("error while loading groups")
                self.isLoading = false
                return
            } else {
                self.groups = groups
                self.dataAvaillable = true
                self.isLoading = false
                self.dataAvaillable = false
            }
        }
    }
    
    func numberOfItem() -> Int {
        guard let groups = groups else { return 0 }
        return groups.count
    }
    
    func addGroup(groupName: String) {
        let group = Group(groupName: groupName)
        FirestoreGroupManager.addGroup(group: group)
        fetchGroup()
    }
    
}
