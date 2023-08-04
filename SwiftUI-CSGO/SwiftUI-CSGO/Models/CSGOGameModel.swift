//
//  CSGOGameModel.swift
//  SwiftUI-CSGO
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import Foundation

struct CSGOGameModel: Codable, Identifiable {
    var id: Int
    var opponents: [CSGOOpponentModel] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.opponents = try container.decodeIfPresent([CSGOOpponentModel].self, forKey: .opponents) ?? []
    }
}
