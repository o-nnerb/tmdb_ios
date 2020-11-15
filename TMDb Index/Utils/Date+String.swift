//
//  Date+String.swift
//  TMDb Index
//
//  Created by brennobemoura on 15/11/20.
//

import Foundation

extension Date {

    init?(_ string: String, locale: Locale = .current, dateFormat: String = "YYYY-mm-dd") {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: string) else {
            return nil
        }

        self = date
    }

    func string(locale: Locale = .current, _ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/YYYY"
        formatter.locale = locale
        return formatter.string(from: self)
    }
}
