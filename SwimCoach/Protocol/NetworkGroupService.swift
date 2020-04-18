//
//  NetworkGroupService.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

/// Protocol used for dependency injection
///
/// We use this protocol to fetch groups from the database
protocol NetworkGroupService {
    func fetchGroup(completion: @escaping ([Group], Error?) -> ())
    func addGroup(group: Group)
    func deleteGroup(group: Group)
}
