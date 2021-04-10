//
//  Security.swift
//  MarvelUI
//
//  Created by Pablo Calcagnino on 10/04/2021.
//

import Foundation
import CryptoKit

struct Security {
    let apiKey = ""
    let privateApiKey = ""
    var timeStamp = Date().timeIntervalSince1970
    var hash: String {
        let digest = Insecure.MD5.hash(data: "\(timeStamp)\(privateApiKey)\(apiKey)".data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
