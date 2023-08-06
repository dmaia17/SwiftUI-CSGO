//
//  PlaceholderImage.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 06/08/23.
//

import SwiftUI

struct PlaceholderImage: View {
    let size: CGFloat
    let cornerRadius: CGFloat?

    init(size: CGFloat, cornerRadius: CGFloat? = nil) {
        self.size = size
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        Color.CSGOGray
            .frame(width: size, height: size)
            .cornerRadius(cornerRadius == nil ? size / 2 : cornerRadius!)
    }
}

struct PlaceholderImage_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImage(size: 60)
    }
}
