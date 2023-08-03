//
//  CSGOPlayerModel.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import Foundation

struct CSGOPlayerModel: Codable {
  var name: String = ""
  var image_url: String = ""
  var slug: String = ""
  var current_team: CSGOOpponentDataModel?

  init() {}

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    self.image_url = try container.decodeIfPresent(String.self, forKey: .image_url) ?? ""
    self.slug = try container.decodeIfPresent(String.self, forKey: .slug) ?? ""
    self.current_team = try container.decodeIfPresent(CSGOOpponentDataModel.self, forKey: .current_team) ?? nil
  }
}
