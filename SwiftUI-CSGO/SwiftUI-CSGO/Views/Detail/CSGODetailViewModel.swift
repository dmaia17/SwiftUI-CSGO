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

    init(service: CSGOServiceProviderProtocol) {
        self.service = service
    }
}
