//
//  CSGODetailView.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import SwiftUI

struct CSGODetailView: View {
    @ObservedObject var viewModel = CSGODetailViewModel(service: CSGOServiceProvider())
    let matchId: Int

    var body: some View {
        Text("Match Detail for ID: \(matchId)")
    }
}

struct CSGODetailView_Previews: PreviewProvider {
    static var previews: some View {
        CSGODetailView(matchId: 1)
    }
}
