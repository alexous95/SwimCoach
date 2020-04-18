//
//  MonthViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 25/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

final class MonthViewModel {
    
    /// The month of a year
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    /// The number of item in the month array
    func numberOfItem() -> Int {
        return months.count
    }
    
}
