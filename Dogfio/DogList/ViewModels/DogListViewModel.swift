//
//  DogListViewModel.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 03/06/25.
//

import Foundation

final class DogListViewModel {
    private var allDogs: [DogInfoResponse] = []
    private var filteredDogs: [DogInfoResponse] = []

    var onDataChanged: (() -> Void)?

    // MARK: Setup DataDog & CoreData
    func loadDogs() {
        if UserDefaults.standard.bool(forKey: "hasLoadedDogs") {
            loadDogsFromLocal()
            //UserDefaults.standard.set(false, forKey: "hasLoadedDogs") //change to false fo chack if call a service
        } else {
            DogService.shared.fetchDogs { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let dogs):
                        self?.allDogs = dogs
                        self?.filteredDogs = dogs
                        self?.onDataChanged?()
                        DogService.shared.saveDogsToCoreData(dogs)
                        UserDefaults.standard.set(true, forKey: "hasLoadedDogs")
                    case .failure(let error):
                        print("Error:", error)
                    }
                }
            }
        }
    }
    
    func loadDogsFromLocal() {
        let localDogs = DogService.shared.fetchDogsFromCoreData()
        self.allDogs = localDogs
        self.filteredDogs = localDogs
        self.onDataChanged?()
    }

    // MARK: Filter
    func filterDogs(query: String) {
        if query.isEmpty {
            filteredDogs = allDogs
        } else {
            filteredDogs = allDogs.filter {
                $0.dogName?.lowercased().contains(query.lowercased()) ?? false
            }
        }
        onDataChanged?()
    }

    func dog(index: Int) -> DogInfoResponse {
        return filteredDogs[index]
    }

    var count: Int {
        return filteredDogs.count
    }
}
