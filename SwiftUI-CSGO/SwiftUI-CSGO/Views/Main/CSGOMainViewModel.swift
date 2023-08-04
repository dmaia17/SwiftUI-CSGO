//
//  CSGOMainViewModel.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import SwiftUI
import Combine

class CSGOMainViewModel: ObservableObject {
    enum State {
        case loading
        case loaded
        case error
    }

    @Published private(set) var state: State = .loading

    @Published var matches: [CSGOMatchModel] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 1
    @Published var hasMorePages: Bool = true

    private let service: CSGOServiceProviderProtocol

    init(service: CSGOServiceProviderProtocol) {
        self.service = service
        self.fetchMatches()
    }

    func fetchMatches() {
        guard !isLoading && hasMorePages else { return }

        isLoading = true

        service.getMatches(page: currentPage, successCallback: { [weak self] response in
            self?.matches.append(contentsOf: response)
            self?.state = .loaded
            self?.isLoading = false
            self?.hasMorePages = !response.isEmpty
        }, failureCallback: { [weak self] in
            self?.isLoading = false
            self?.state = .error
        })
    }
}
