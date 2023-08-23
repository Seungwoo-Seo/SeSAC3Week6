//
//  Cinema.swift
//  SeSAC3Week6
//
//  Created by 서승우 on 2023/08/24.
//

import Foundation

struct CinemaContainerContainer: Decodable {
    let cinemaContainer: CinemaContainer

    enum CodingKeys: String, CodingKey {
        case cinemaContainer = "LOCALDATA_031302"
    }
}

struct CinemaContainer: Decodable {
    let cinemaList: [Cinema]

    enum CodingKeys: String, CodingKey {
        case cinemaList = "row"
    }
}

struct Cinema: Decodable {
    let roadAddress: String
    let name: String
    let x: String
    let y: String

    var xDouble: Double {
        return Double(x) ?? 0
    }

    var yDouble: Double {
        return Double(y) ?? 0
    }

    enum CodingKeys: String, CodingKey {
        case roadAddress = "RDNWHLADDR"
        case name = "BPLCNM"
        case x = "X"
        case y = "Y"
    }

}
