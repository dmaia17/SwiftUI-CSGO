//
//  View+Ext.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 04/08/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
