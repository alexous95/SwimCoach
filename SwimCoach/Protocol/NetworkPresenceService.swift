//
//  NetworkPresenceService.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

protocol NetworkPresenceService {
    func addPresence(personID: String, from group: Group, stringDate: String)
    func fetchPresence(personID: String, date: String, from group: Group, completion: @escaping ([String], Error?) -> ())
}
