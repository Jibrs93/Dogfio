//
//  DogModel.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 02/06/25.
//

import Foundation

// MARK: Model ResponseDog
struct DogInfoResponse: Codable {
    let dogName: String?
    let description: String?
    let age: Int?
    let image: String?
}
