//
//  NetworkPersonService.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

/// Protocol used for dependency injection
///
/// We use this protocol to fetch, add and delete persons from the database
protocol NetworkPersonService {
    func fetchPersons(from group: Group, completion: @escaping ([Person], Error?) -> ())
    func addPerson(lastName: String, firstName: String, to group: Group)
    func deletePerson(personID: String, from group: Group)
}
