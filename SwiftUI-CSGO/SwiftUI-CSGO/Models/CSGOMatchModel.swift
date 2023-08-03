//
//  CSGOMatchModel.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import Foundation

struct CSGOMatchModel: Codable {
  var id: Int = 0
  var league: CSGOLeagueModel?
  var status: MatchStatus = .not_started
  var begin_at: String = ""
  var games: [CSGOGameModel]?
  var opponents: [CSGOOpponentModel]?

  init() {}

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    self.league = try container.decodeIfPresent(CSGOLeagueModel.self, forKey: .league) ?? nil
    self.status = try container.decodeIfPresent(MatchStatus.self, forKey: .status) ?? .not_started
    self.begin_at = try container.decodeIfPresent(String.self, forKey: .begin_at) ?? ""
    self.games = try container.decodeIfPresent([CSGOGameModel].self, forKey: .games) ?? nil
    self.opponents = try container.decodeIfPresent([CSGOOpponentModel].self, forKey: .opponents) ?? nil
  }
}

enum MatchStatus: String, Codable {
  case running = "running"
  case not_started = "not_started"
}
