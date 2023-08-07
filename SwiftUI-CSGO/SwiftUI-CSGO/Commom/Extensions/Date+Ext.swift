//
//  Date+Ext.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 07/08/23.
//

import Foundation

public extension Date {
    func dayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEE")
        return dateFormatter.string(from: self)
    }

    func dayAndMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd-MM"
        return dateFormatter.string(from: self)
    }

    func hourAndMin() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }

    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isMoreThanSevenDay: Bool {
        let components = Calendar.current.dateComponents([.day], from: Date(), to: self)

        guard let differenceDay = components.day else {
            return false
        }

        return differenceDay >= 7
    }
}
