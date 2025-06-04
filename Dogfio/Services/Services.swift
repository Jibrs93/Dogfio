//
//  Services.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 03/06/25.
//

import Foundation
import UIKit
import CoreData

let baseURL = "https://jsonblob.com/"

final class DogService {
    private let hasLoadedDogsKey = "hasLoadedDogs"
    static let shared = DogService()
    private let urlString = baseURL + "api/1151549092634943488"

    
    // MARK: - Fetch from URL
    func fetchDogs(completion: @escaping (Result<[DogInfoResponse], Error>) -> Void) {
        print("Call service 📡")
        guard let url = URL(string: urlString) else {
            return completion(.failure(NSError(domain: "", code: -1)))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let dogs = try JSONDecoder().decode([DogInfoResponse].self, from: data)
                    completion(.success(dogs))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }

    // MARK: - Save to Core Data
    func saveDogsToCoreData(_ dogs: [DogInfoResponse]) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }

        // Remove existing entries
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DogInfoEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch {
            print("❌ Error clearing old DogInfoEntities:", error)
        }

        // Insert new ones
        for dog in dogs {
            let entity = DogInfoEntity(context: context)
            entity.dogName = dog.dogName
            entity.desc = dog.description
            entity.age = Int16(dog.age ?? 0)
            entity.image = dog.image
        }

        do {
            try context.save()
            print("✅ Saved to Core Data")
        } catch {
            print("❌ Error saving to Core Data:", error)
        }
    }

    // MARK: - Fetch from Core Data
    func fetchDogsFromCoreData() -> [DogInfoResponse] {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return []
        }

        let request: NSFetchRequest<DogInfoEntity> = DogInfoEntity.fetchRequest()

        do {
            let entities = try context.fetch(request)
            return entities.map {
                DogInfoResponse(
                    dogName: $0.dogName ?? "",
                    description: $0.desc ?? "",
                    age: Int($0.age),
                    image: $0.image ?? ""
                )
            }
        } catch {
            print("❌ Error fetching from Core Data:", error)
            return []
        }
    }
}
