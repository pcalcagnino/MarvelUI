//
//  MarvelResponse.swift
//  MarvelUI
//
//  Created by Pablo Calcagnino on 08/04/2021.
//

import Foundation

struct MarvelResponse<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: MarvelData<T>
}

struct MarvelData<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
