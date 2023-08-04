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

    // MARK: Public methods
    func fetchMatches() {
        guard !isLoading && hasMorePages else { return }

        isLoading = true

        service.getMatches(page: currentPage, successCallback: { [weak self] response in
            self?.handleMatchSuccessResponse(response: response)
        }, failureCallback: { [weak self] in
            self?.handleMatchErrorResponse()
        })
    }

    func refreshMatches() {
        hasMorePages = true
        currentPage = 1
        fetchMatches()
    }

    // MARK: Private methods

    private func handleMatchSuccessResponse(response: [CSGOMatchModel]) {
        if currentPage == 1 {
            matches = response
        } else {
            matches.append(contentsOf: response)
        }

        state = .loaded
        isLoading = false
        hasMorePages = !response.isEmpty
    }

    private func handleMatchErrorResponse() {
        isLoading = false
        state = .error
    }
}
