//
//  WorkoutLine.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

final class WorkoutLine {
    
    var text: String = ""
    var zone1: Double = 0.0
    var zone2: Double = 0.0
    var zone3: Double = 0.0
    var zone4: Double = 0.0
    var zone5: Double = 0.0
    var zone6: Double = 0.0
    var zone7: Double = 0.0
    var ampM: Double = 0.0
    var coorM: Double = 0.0
    var endM: Double = 0.0
    var educ: Double = 0.0
    var crawl: Double = 0.0
    var medley: Double = 0.0
    var spe: Double = 0.0
    var nageC: Double = 0.0
    var jbs: Double = 0.0
    var bras: Double = 0.0
    var workoutLineID: String
    
    init(text: String, zone1: Double, zone2: Double, zone3: Double, zone4: Double, zone5: Double, zone6: Double, zone7: Double, ampM: Double, coorM: Double, endM: Double, educ: Double, crawl: Double, medley: Double, spe: Double, nageC: Double, jbs: Double, bras: Double, workoutLineID: String) {
        self.text = text
        self.zone1 = zone1
        self.zone2 = zone2
        self.zone3 = zone3
        self.zone4 = zone4
        self.zone5 = zone5
        self.zone6 = zone6
        self.zone7 = zone7
        self.ampM = ampM
        self.coorM = coorM
        self.endM = endM
        self.educ = educ
        self.crawl = crawl
        self.medley = medley
        self.spe = spe
        self.nageC = nageC
        self.jbs = jbs
        self.bras = bras
        self.workoutLineID = workoutLineID
    }
    
    var dictionnary: [String : Any] {
        return ["text" : self.text,
                "zone1" : self.zone1,
                "zone2" : self.zone2,
                "zone3" : self.zone3,
                "zone4" : self.zone4,
                "zone5" : self.zone5,
                "zone6" : self.zone6,
                "zone7" : self.zone7,
                "ampM" : self.ampM,
                "coorM" : self.coorM,
                "endM" : self.endM,
                "educ": self.educ,
                "crawl" : self.crawl,
                "medley" : self.medley,
                "spe" : self.spe,
                "nageC" : self.nageC,
                "jbs" : self.jbs,
                "bras" : self.bras,
                "workoutLineID" : self.workoutLineID
        ]
    }
    
    convenience init?(document: [String : Any]) {
        guard let text = document["text"] as? String else { return nil }
        guard let zone1 = document["zone1"] as? Double else { return nil }
        guard let zone2 = document["zone2"] as? Double else { return nil }
        guard let zone3 = document["zone3"] as? Double else { return nil }
        guard let zone4 = document["zone4"] as? Double else { return nil }
        guard let zone5 = document["zone5"] as? Double else { return nil }
        guard let zone6 = document["zone6"] as? Double else { return nil }
        guard let zone7 = document["zone7"] as? Double else { return nil }
        guard let ampM = document["ampM"] as? Double else { return nil }
        guard let coorM = document["coorM"] as? Double else { return nil }
        guard let endM = document["endM"] as? Double else { return nil }
        guard let educ = document["educ"] as? Double else { return nil }
        guard let crawl = document["crawl"] as? Double else { return nil }
        guard let medley = document["medley"] as? Double else { return nil }
        guard let spe = document["spe"] as? Double else { return nil }
        guard let nageC = document["nageC"] as? Double else { return nil }
        guard let jbs = document["jbs"] as? Double else { return nil }
        guard let bras = document["bras"] as? Double else { return nil }
        guard let workoutLineID = document["workoutLineID"] as? String else { return nil }
        
        self.init(text: text, zone1: zone1, zone2: zone2, zone3: zone3, zone4: zone4, zone5: zone5, zone6: zone6, zone7: zone7, ampM: ampM, coorM: coorM, endM: endM, educ: educ, crawl: crawl, medley: medley, spe: spe, nageC: nageC, jbs: jbs, bras: bras, workoutLineID: workoutLineID)
    }
    
    func getDistance() -> Double {
        return zone1 + zone2 + zone3 + zone4 + zone5 + zone6 + zone7
    }
    
    func addZ1(distance: Double) {
        zone1 += distance
    }
    
    func getZ1() -> Double {
        return zone1
    }
    
    func addZ2(distance: Double) {
        zone2 += distance
    }
    
    func getZ2() -> Double {
        return zone2
    }
    
    func addZ3(distance: Double) {
        zone3 += distance
    }
    
    func getZ3() -> Double {
        return zone3
    }
    
    func addZ4(distance: Double) {
        zone4 += distance
    }
    
    func getZ4() -> Double {
        return zone4
    }
    
    func addZ5(distance: Double) {
        zone5 += distance
    }
    
    func getZ5() -> Double {
        return zone5
    }
    
    func addZ6(distance: Double) {
        zone6 += distance
    }
    
    func getZ6() -> Double {
        return zone6
    }
    
    func addZ7(distance: Double) {
        zone7 += distance
    }
    
    func getZ7() -> Double {
        return zone7
    }
    
    func getAmpM() -> Double {
        return ampM
    }
    
    func getCoorM() -> Double {
        return coorM
    }
    
    func getEndM() -> Double {
        return endM
    }
    
    func getEduc() -> Double {
        return educ
    }
    
    func getCrawl() -> Double {
        return crawl
    }
    
    func getMedley() -> Double {
        return medley
    }
    
    func getSpe() -> Double {
        return spe
    }
    
    func getNageC() -> Double {
        return nageC
    }
    
    func getJbs() -> Double {
        return jbs
    }
    
    func getBras() -> Double {
        return bras
    }
    
}
