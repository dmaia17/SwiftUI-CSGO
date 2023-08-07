//
//  MockCSGOServiceProvider.swift
//  SwiftUI-CSGOTests
//
//  Created by Daniel Maia dos Passos on 07/08/23.
//

import Foundation
@testable import SwiftUI_CSGO

class MockCSGOServiceProvider: CSGOServiceProviderProtocol {
    func getMatches(page: Int, successCallback: @escaping ([CSGOMatchModel]) -> Void, failureCallback: @escaping () -> Void) {

    }

    func getPlayers(team1: Int, team2: Int, successCallback: @escaping ([SwiftUI_CSGO.CSGOPlayerModel]) -> Void, failureCallback: @escaping () -> Void) {

    }
}
