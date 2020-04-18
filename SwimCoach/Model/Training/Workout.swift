//
//  Workout.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

final class Workout {
    
    // MARK: - Variables
    
    /// The workout's title
    var title: String = ""
    
    /// The workout's date
    var date: String = ""
    
    /// The workout's ID
    var workoutID: String = ""
    
    /// The workout's lines
    var workoutLines: [WorkoutLine] = []
    
    /// Stored property that is used to add objects to Firestore
    var dictionnary: [String : Any] {
        return ["title" : self.title,
                "date" : self.date,
                "workoutID" : self.workoutID
        ]
    }
    
    // MARK: - Init
    
    init(title: String, date: String, workoutID: String, workoutLines: [WorkoutLine] = []) {
        self.title = title
        self.date = date
        self.workoutID = workoutID
        self.workoutLines = workoutLines
    }
    
    init() {}
    
    convenience init?(document: [String : Any]) {
        guard let title = document["title"] as? String else { return nil }
        guard let date = document["date"]  as? String else { return nil }
        guard let workoutID = document["workoutID"] as? String else { return nil }
        self.init(title: title, date: date, workoutID: workoutID)
    }
    
    // MARK: - Zone Functions
    
    /// Returns the total distance of a workout
    func getDistance() -> Double {
        var distance = 0.0
        for workout in workoutLines {
            distance += workout.getDistance()
        }
        
        return distance
    }
    
    /// Returns the total zone 1 distance
    func getDistanceZ1() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ1()
        }
        
        return distance
    }
    
    /// Returns the total zone 2 distance
    func getDistanceZ2() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ2()
        }
        
        return distance
    }
    
    /// Returns the total zone 3 distance
    func getDistanceZ3() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ3()
        }
        
        return distance
    }
    
    /// Returns the total zone 4 distance
    func getDistanceZ4() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ4()
        }
        
        return distance
    }
    
    /// Returns the total zone 5 distance
    func getDistanceZ5() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ5()
        }
        
        return distance
    }
    
    /// Returns the total zone 6 distance
    func getDistanceZ6() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ6()
        }
        
        return distance
    }
    
    /// Returns the total zone 7 distance
    func getDistanceZ7() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ7()
        }
        
        return distance
    }
    
    /// Returns a the workout text formatted
    func description() -> [String] {
        var descriptionLine = [String]()
        
        for workout in workoutLines {
            descriptionLine.append(workout.workoutLineTitle + "\n \n" + workout.text)
        }
        
        return descriptionLine
    }
    
    // MARK: - Motricity Functions
    
    /// Returns the total AmpM distance
    func getDistanceAmpM() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getAmpM()
        }
        
        return distance
    }
    
    /// Returns the total CoorM distance
    func getDistanceCoorM() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getCoorM()
        }
        
        return distance
    }
    
    /// Returns the total EndM distance
    func getDistanceEndM() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getEndM()
        }
        
        return distance
    }
    
    /// Returns the total educ distance
    func getDistanceEduc() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getEduc()
        }
        
        return distance
    }
    
    /// Returns the total crawl distance
    func getDistanceCrawl() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getCrawl()
        }
        
        return distance
    }
    
    /// Returns the total medley distance
    func getDistanceMedley() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getMedley()
        }
        
        return distance
    }
    
    /// Returns the total spe distance
    func getDistanceSpe() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getSpe()
        }
        
        return distance
    }
    
    /// Returns the total NageC distance
    func getDistanceNageC() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getNageC()
        }
        
        return distance
    }
    
    /// Returns the total jbs distance
    func getDistanceJbs() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getJbs()
        }
        
        return distance
    }
    
    /// Returns the total bras distance
    func getDistanceBras() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getBras()
        }
        
        return distance
    }
    
}
