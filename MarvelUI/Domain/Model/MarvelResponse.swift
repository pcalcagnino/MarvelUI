//
//  MarvelResponse.swift
//  MarvelUI
//
//  Created by Pablo Calcagnino on 08/04/2021.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    var code: Int
    var status: String
    var data: MarvelData<T>
}

struct MarvelData<T: Decodable>: Decodable {
    var offset: Int
    var limit: Int
    var total: Int
    var count: Int
    var results: [T]
}
