//
//  StringExtension.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation

extension String {
    func formatToDate(dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        return dateFormatter.date(from: self)!
    }
}
