//
//  Date+Extensions.swift
//  DayView
//
//  Created by Naveen Magatala on 1/31/19.
//

extension Date {
    var shortday: String {
        let formatter = DateController.shared.dateFormatter
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    var appDate: Date {
        let formatter = DateController.shared.dateFormatter
        formatter.dateFormat = "yyyy MM dd"
        let date = formatter.string(from: self)
        return formatter.date(from: date)!
    }
    
    var detailedDate: String {
        let formatter = DateController.shared.dateFormatter
        formatter.setLocalizedDateFormatFromTemplate("MMMM dd, yyyy")
        return formatter.string(from: self)
    }
}
