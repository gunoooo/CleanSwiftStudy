//
//  DateExtension.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
 
extension Date {
    func formatToString(dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.string(from: self)
    }
}
