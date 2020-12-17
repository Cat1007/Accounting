//
//  UTCTime.swift
//  accounting
//
//  Created by 叶锦浩 on 2020/12/17.
//  Copyright © 2020 group. All rights reserved.
//

import Foundation

class UTCTime {
    var date: Date
    var year: Int
    var month: Int
    var day: Int
    
    init(date: Date?) {
        var GMTDate: Date
        
        if date == nil {
            GMTDate = Date()
        } else {
            GMTDate = date!
        }
        
        let zone = TimeZone.current
        let interval = zone.secondsFromGMT()
        let now = GMTDate.addingTimeInterval(TimeInterval(interval))
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        let tempDate =  dateformatter.string(from: now).split(separator: "-")
        
        year = Int(tempDate[0])!
        month = Int(tempDate[1])!
        day = Int(tempDate[2])!
        
        self.date = now
        
    }
    
    func getTimeString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"
        return dateformatter.string(from: date)
    }
}
