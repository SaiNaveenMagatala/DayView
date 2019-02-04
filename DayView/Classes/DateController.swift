//
//  DateController.swift
//  DayView
//
//  Created by Naveen Magatala on 1/31/19.
//

class DateController {
    
    private init() { }
    
    static let shared = DateController()
    
    lazy var todayDate: Date = {
        return getDay(value: 0, from: date)
    }()
    
    private let date = Date()
    let dateFormatter = DateFormatter()
    let calendar = Calendar(identifier: .gregorian)
    
    lazy var twentyOnedays: [Date] = {
        var days = [Date]()
        for value in -7...13 {
            days.append(getDay(value: value))
        }
        return days
    }()
    
    var twentyOneStringDays: [String] {
        return twentyOnedays.compactMap({ day in
            day.shortday
        })
    }
    
    func fetchPastWeek() {
        var days = [Date]()
        for value in -7 ... -1 {
            let date = calendar.date(byAdding: .day, value: value, to: twentyOnedays.first!)
            days.append(date!)
        }
        twentyOnedays.insert(contentsOf: days, at: 0)
    }
    
    func fetchNextWeek() {
        var days = [Date]()
        for value in 1...7 {
            let date = calendar.date(byAdding: .day, value: value, to: twentyOnedays.last!)
            days.append(date!)
        }
        twentyOnedays.append(contentsOf: days)
    }
    
    func getDay(value: Int, from date: Date? = nil) -> Date {
        let usageDate = date ?? getFirstDayOfWeek()
        return calendar.date(byAdding: .day, value: value, to: usageDate)!.appDate
    }
    
    func getFirstDayOfWeek(day: Date? = nil) -> Date {
        let day = day ?? date
        let firstDayOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: day))
        return firstDayOfWeek!.appDate
    }
    
    func getFirstDayOfPreviousWeek(day: Date? = nil) -> Date {
        let firstDay = getFirstDayOfWeek(day: day)
        let firstDayInPreviousWeek = calendar.date(byAdding: .day, value: -7, to: firstDay)
        return firstDayInPreviousWeek!.appDate
    }
    
    func getFirstDayOfNextWeek(day: Date? = nil) -> Date {
        let firstDay = getFirstDayOfWeek(day: day)
        let firstDayInNextWeek = calendar.date(byAdding: .day, value: 7, to: firstDay)
        return firstDayInNextWeek!.appDate
    }
    
    func getStringDay(value: Int, from date: Date? = nil) -> String {
        let day = getDay(value: value, from: date)
        return dateFormatter.string(from: day)
    }
}
