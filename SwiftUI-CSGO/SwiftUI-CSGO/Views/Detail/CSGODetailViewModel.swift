//
//  CSGODetailViewModel.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import SwiftUI
import Combine

class CSGODetailViewModel: ObservableObject {
    private let service: CSGOServiceProviderProtocol
    let match: CSGOMatchModel

    var firstTeamId: Int = 0
    var secondTeamId: Int = 0
    var firstPlayerList: [CSGOPlayerModel] = []
    var secondPlayerList: [CSGOPlayerModel] = []

    @Published private(set) var state: State = .loading
    @Published var timeStatus: String = ""

    enum Strings {
        static let running = "AGORA"
        static let today = "HOJE"
        static let timeFormat = "%@, %@"
    }

    init(match: CSGOMatchModel, service: CSGOServiceProviderProtocol) {
        self.match = match
        self.service = service
    }

    // MARK: Public methods

    func loadData() {
        setTimeStatus()
        let opponents = getOpponents()

        if !opponents.isEmpty {
          firstTeamId = opponents[0].opponent?.id ?? 0
          secondTeamId = opponents[1].opponent?.id ?? 0

          getPlayers(team1: firstTeamId, team2: secondTeamId)
        } else {
            state = .error
        }
    }

    // MARK: Private methods
    
    private func getPlayers(team1: Int, team2: Int) {
        service.getPlayers(team1: team1, team2: team2, successCallback: { [weak self] response in
            self?.handleMatchSuccessResponse(response: response)
        }, failureCallback: { [weak self] in
            self?.handleMatchErrorResponse()
        })
    }

    private func handleMatchSuccessResponse(response: [CSGOPlayerModel]) {
        configLists(list: response)
        state = .loaded
    }

    private func handleMatchErrorResponse() {
        state = .error
    }

    private func getOpponents() -> [CSGOOpponentModel] {
        if let opponents = match.opponents, !opponents.isEmpty, opponents.count > 1 {
            return [opponents[0], opponents[1]]
        } else {
            return []
        }
    }

    private func configLists(list: [CSGOPlayerModel]) {
      firstPlayerList = list.filter { $0.current_team?.id == firstTeamId }
      secondPlayerList = list.filter { $0.current_team?.id == secondTeamId }
    }

    private func setTimeStatus() {
        if match.status == .running {
          timeStatus = Strings.running
        } else {
          let date = match.begin_at.toDate() ?? .now

          if date.isInToday {
              timeStatus = String(format: Strings.timeFormat, Strings.today, date.hourAndMin())
          } else if date.isMoreThanSevenDay {
              timeStatus = String(format: Strings.timeFormat, date.dayAndMonth(), date.hourAndMin()).replacingOccurrences(of: ".", with: "")
          } else {
              timeStatus = String(format: Strings.timeFormat, date.dayName().uppercased(), date.hourAndMin()).replacingOccurrences(of: ".", with: "")
          }
        }
    }
}
