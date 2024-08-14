//
//  DataRange.swift
//  SportsAppITI
//
//  Created by Engy on 8/14/24.
//

import Foundation
enum DataRange: String {
    case upcoming
    case passed
    case now

    var currentDate:DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day], from: Date.now)
    }
    var year: String {
        switch self {
        case .upcoming:
            return "\(currentDate.year!+1)-\(currentDate.month!)-\(currentDate.day!)"
        case .passed:
            return "\(currentDate.year!-1)-\(currentDate.month!)-\(currentDate.day!)"
        case .now:
            return "\(currentDate.year!)-\(currentDate.month!)-\(currentDate.day!)"
        }
    }
}
