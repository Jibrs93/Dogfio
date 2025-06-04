//
//  DogListTests.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 03/06/25.
//

import XCTest
@testable import Dogfio

final class DogListTests: XCTestCase {

    var viewModel: DogListViewModel!

    override func setUpWithError() throws {
        viewModel = DogListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLoadDogsFromLocal() {
        let mockDog = DogInfoResponse(dogName: "Fido", description: "Test dog", age: 3, image: "fido.png")
        DogService.shared.saveDogsToCoreData([mockDog])
        UserDefaults.standard.set(true, forKey: "hasLoadedDogs")

        viewModel.loadDogs()

        XCTAssertEqual(viewModel.count, 1)
        XCTAssertEqual(viewModel.dog(index: 0).dogName, "Fido")
    }

    func testFilterDogs_withMatch() {
        let dogs = [
            DogInfoResponse(dogName: "Fido", description: "Test dog", age: 3, image: "fido.png"),
            DogInfoResponse(dogName: "Buddy", description: "Friendly dog", age: 5, image: "buddy.png"),
            DogInfoResponse(dogName: "Max", description: "Playful dog", age: 2, image: "max.png")
        ]
        DogService.shared.saveDogsToCoreData(dogs)
        UserDefaults.standard.set(true, forKey: "hasLoadedDogs")

        viewModel.loadDogs()
        viewModel.filterDogs(query: "bud")

        XCTAssertEqual(viewModel.count, 1)
        XCTAssertEqual(viewModel.dog(index: 0).dogName, "Buddy")
    }

    func testFilterDogs_emptyQueryShowsAll() {
        let dogs = [
            DogInfoResponse(dogName: "Fido", description: "Test dog", age: 3, image: "fido.png"),
            DogInfoResponse(dogName: "Buddy", description: "Friendly dog", age: 5, image: "buddy.png")
        ]
        DogService.shared.saveDogsToCoreData(dogs)
        UserDefaults.standard.set(true, forKey: "hasLoadedDogs")

        viewModel.loadDogs()
        viewModel.filterDogs(query: "")

        XCTAssertEqual(viewModel.count, 2)
    }
}
