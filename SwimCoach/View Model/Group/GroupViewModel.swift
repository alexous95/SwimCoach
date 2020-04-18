//
//  HomeScreenViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 16/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine

final class GroupViewModel {
    
    // MARK: - Variables
    
    /// Publisher for the activity wheel
    @Published var isLoading: Bool = false
    
    /// Publisher that is used as a signal of new available data
    @Published var dataAvaillable: Bool = false
    
    /// Array that strore our fetched group
    var groups: [Group]?
    
    /// Dependency injection
    ///
    /// We mock this property to test our code
    private let network: NetworkGroupService
    
    // MARK: - Init
    
    init(manager: NetworkGroupService = FirestoreGroupManager()) {
        self.network = manager
    }
        
    // MARK: - Database Functions
    
    /// Fetch data from FireStore and updates the publisher to signal there is data availlable
    ///
    /// In this function we change the value of our publisher to update the UI in the view controller
    func fetchGroup() {
        isLoading = true
        network.fetchGroup { (groups, error) in
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
    
    /// Returns the number of groups
    ///
    /// - Returns: An int representing our array count
    func numberOfItem() -> Int {
        guard let groups = groups else { return 0 }
        return groups.count
    }
    
    /// Adds a group to the database
    ///
    /// We use our network property to add the group to the database and update our data
    func addGroup(groupName: String) {
        let group = Group(groupName: groupName)
        network.addGroup(group: group)
        fetchGroup()
    }
    
    /// Deletes a group from the database
    /// - Parameter group: The group we want to delete
    ///
    /// We use the network property to delete the group from the database and update our data
    func deleteGroup(group: Group) {
        network.deleteGroup(group: group)
        fetchGroup()
    }
    
}
