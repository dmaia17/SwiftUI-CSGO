//
//  CSGOMainViewModel.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import SwiftUI
import Combine

class CSGOMainViewModel: ObservableObject {

    @Published private(set) var state: State = .loading
    @Published var matches: [CSGOMatchModel] = []
    @Published var currentPage: Int = 1
    @Published var hasMorePages: Bool = true
    @Published var matchId: Int?

    private let service: CSGOServiceProviderProtocol

    init(service: CSGOServiceProviderProtocol) {
        self.service = service
        self.fetchMatches()
    }

    // MARK: Public methods
    
    func fetchMatches() {
        guard hasMorePages else { return }

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
        hasMorePages = !response.isEmpty
    }

    private func handleMatchErrorResponse() {
        state = .error
    }
}
