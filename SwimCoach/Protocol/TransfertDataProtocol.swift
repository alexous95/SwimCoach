//
//  TransfertDataProtocol.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 03/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

/// Protocol used to transfer a certain type of data between Controllers
protocol TransfertDataProtocol {
    func getData(data: WorkoutLine)
}
