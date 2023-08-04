//
//  CSGOMainView.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import SwiftUI

struct CSGOMainView: View {
    @ObservedObject var viewModel = CSGOMainViewModel(service: CSGOServiceProvider())

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded:
                listView
            case .error:
                errorView
            }
        }
    }

    private var listView: some View {
        List(viewModel.matches) { match in
            Text(match.begin_at)
        }
        .refreshable {
            viewModel.currentPage = 1
            viewModel.fetchMatches()
        }
    }

    private var errorView: some View {
        Text("Ocorreu um erro!")
    }
}

struct CSGOMainView_Previews: PreviewProvider {
    static var previews: some View {
        CSGOMainView()
    }
}
