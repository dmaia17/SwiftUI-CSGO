//
//  CSGOServiceProvider.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import Alamofire

protocol CSGOServiceProviderProtocol {
    /**
     * Endpoint: https://api.pandascore.co/csgo/matches
     * Type: GET
     */
    func getMatches(page: Int, successCallback: @escaping ([CSGOMatchModel]) -> Void, failureCallback: @escaping () -> Void)

    /**
     * Endpoint: https://api.pandascore.co/csgo/players
     * Type: GET
     */
    func getPlayers(team1: Int, team2: Int, successCallback: @escaping ([CSGOPlayerModel]) -> Void, failureCallback: @escaping () -> Void)
}

class CSGOServiceProvider {
    private func createHeader() -> HTTPHeaders {
        return ["Authorization": "Bearer PuGrJQfA8PLjZgTw-135Tq4G0qcRtg6B-sMblLPu4Xdfb1DrjnU", "Accept": "application/json"]
    }
}

extension CSGOServiceProvider: CSGOServiceProviderProtocol {
    func getMatches(page: Int, successCallback: @escaping ([CSGOMatchModel]) -> Void, failureCallback: @escaping () -> Void) {
        print("https://api.pandascore.co/csgo/matches?sort=-status,begin_at&filter[status]=not_started,running&page=\(page)&per_page=50")

        AF.request("https://api.pandascore.co/csgo/matches?sort=-status,begin_at&filter[status]=not_started,running&page=\(page)&per_page=50", headers: createHeader())
            .validate()
            .responseDecodable(of: [CSGOMatchModel].self) { response in
                print(response)

                guard let matchModel = response.value else {
                    failureCallback()
                    return
                }

                successCallback(matchModel)
            }
    }

    func getPlayers(team1: Int, team2: Int, successCallback: @escaping ([CSGOPlayerModel]) -> Void, failureCallback: @escaping () -> Void) {
        AF.request("https://api.pandascore.co/csgo/players?sort=name&filter[team_id]=\(team2),\(team1)", headers: createHeader())
            .validate()
            .responseDecodable(of: [CSGOPlayerModel].self) { response in
                guard let players = response.value else {
                    failureCallback()
                    return
                }

                successCallback(players)
            }
    }
}
