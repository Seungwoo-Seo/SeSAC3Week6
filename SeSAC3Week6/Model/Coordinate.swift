//
//  Coordinate.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/24.
//

import Foundation

struct CoordinateContainer: Codable {
    let coordinateList: [Coordinate]

    enum CodingKeys: String, CodingKey {
        case coordinateList = "documents"
    }
}

struct Coordinate: Codable {
    let x, y: Double
}
