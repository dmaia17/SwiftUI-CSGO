//
//  CSGOMainViewModelTests.swift
//  SwiftUI-CSGOTests
//
//  Created by Daniel Maia dos Passos on 02/08/23.
//

import XCTest
@testable import SwiftUI_CSGO

final class CSGOMainViewModelTests: XCTestCase {
    var viewModel: CSGOMainViewModel!
    var mockService: MockCSGOServiceProvider!

    override func setUp() {
        super.setUp()
        mockService = MockCSGOServiceProvider()
        viewModel = CSGOMainViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testGetMatchDateStatus() {
        // Given
        let todayMatch = CSGOMatchModel(begin_at: "2023-08-07T12:30:00Z")
        let matchInSevenDays = CSGOMatchModel(begin_at: "2023-08-14T15:00:00Z")
        let pastSevenDaysMatch = CSGOMatchModel(begin_at: "2023-07-30T08:45:00Z")

        // When
        let todayStatus = viewModel.getMatchDateStatus(match: todayMatch)
        let sevenDaysStatus = viewModel.getMatchDateStatus(match: matchInSevenDays)
        let pastSevenDaysStatus = viewModel.getMatchDateStatus(match: pastSevenDaysMatch)

        // Then
        XCTAssertEqual(todayStatus, "HOJE, 12:30")
        XCTAssertEqual(sevenDaysStatus, "14-08, 15:00")
        XCTAssertEqual(pastSevenDaysStatus, "DOM, 08:45")
    }
}

extension CSGOMainViewModelTests {
    // Helper method to convert the date string to a Date object
    func createDate(from dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: dateString)
    }
}


