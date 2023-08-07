//
//  Font+Ext.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 07/08/23.
//

import Foundation
import SwiftUI

public enum AppFont: String, CaseIterable {
    case regular = "Roboto-Regular"
    case bold = "Roboto-Bold"
}

extension Font {
    public static var regular8: Font {
        Font.custom(AppFont.regular.rawValue, size: 8)
    }

    public static var regular10: Font {
        Font.custom(AppFont.regular.rawValue, size: 10)
    }

    public static var regular12: Font {
        Font.custom(AppFont.regular.rawValue, size: 12)
    }

    public static var bold8: Font {
        Font.custom(AppFont.bold.rawValue, size: 8)
    }

    public static var bold12: Font {
        Font.custom(AppFont.bold.rawValue, size: 12)
    }

    public static var bold14: Font {
        Font.custom(AppFont.bold.rawValue, size: 14)
    }
}
