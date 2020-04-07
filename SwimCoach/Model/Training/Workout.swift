//
//  Workout.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

final class Workout {
    
    var title: String = ""
    var date: String = ""
    var workoutID: String = ""
    
    var workoutLines: [WorkoutLine] = []
    
    init(title: String, date: String, workoutID: String, workoutLines: [WorkoutLine] = []) {
        self.title = title
        self.date = date
        self.workoutID = workoutID
    }
    
    init() {}
    
    var dictionnary: [String : Any] {
        return ["title" : self.title,
                "date" : self.date,
                "workoutID" : self.workoutID
               ]
    }
    
    convenience init?(document: [String : Any]) {
        guard let title = document["title"] as? String else { return nil }
        guard let date = document["date"]  as? String else { return nil }
        guard let workoutID = document["workoutID"] as? String else { return nil }
        self.init(title: title, date: date, workoutID: workoutID)
    }
    
   
    func getDistance() -> Double {
        var distance = 0.0
        for workout in workoutLines {
            distance += workout.getDistance()
        }
        
        return distance
    }
    
    func getDistanceZ1() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ1()
        }
        
        return distance
    }
    
    func getDistanceZ2() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ2()
        }
        
        return distance
    }
    
    func getDistanceZ3() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ3()
        }
        
        return distance
    }
    
    func getDistanceZ4() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ4()
        }
        
        return distance
    }
    
    func getDistanceZ5() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ5()
        }
        
        return distance
    }
    
    func getDistanceZ6() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ6()
        }
        
        return distance
    }
    
    func getDistanceZ7() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getZ7()
        }
        
        return distance
    }
    
    func description() -> [String] {
        var descriptionLine = [String]()
        
        for workout in workoutLines {
            descriptionLine.append(workout.text)
        }
        
        return descriptionLine
    }
    
    func getDistanceAmpM() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getAmpM()
        }
        
        return distance
    }
    
    func getDistanceCoorM() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getCoorM()
        }
        
        return distance
    }
    
    func getDistanceEndM() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getEndM()
        }
        
        return distance
    }
    
    func getDistanceEduc() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getEduc()
        }
        
        return distance
    }
    
    func getDistanceCrawl() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getCrawl()
        }
        
        return distance
    }
    
    func getDistanceMedley() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getMedley()
        }
        
        return distance
    }
    
    func getDistanceSpe() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getSpe()
        }
        
        return distance
    }
    
    func getDistanceNageC() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getNageC()
        }
        
        return distance
    }
    
    func getDistanceJbs() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getJbs()
        }
        
        return distance
    }
    
    func getDistanceBras() -> Double {
        var distance = 0.0
        
        for workout in workoutLines {
            distance += workout.getBras()
        }
        
        return distance
    }
    
}
