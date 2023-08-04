//
//  CSGOLeagueModel.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import Foundation

struct CSGOLeagueModel: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var image_url: String = ""

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.image_url = try container.decodeIfPresent(String.self, forKey: .image_url) ?? ""
    }
}
