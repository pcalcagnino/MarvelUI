//
//  MarvelAPI.swift
//  MarvelUI
//
//  Created by Pablo Calcagnino on 08/04/2021.
//

import Foundation
import Combine
import CryptoKit

struct Security {
    let apiKey = "3afffc31426bfa5a2c00e9b68bd6c8ec"
    let privateApiKey = "db315265d0b3892a4ac46a551732bf1b77fb4b17"
    var timeStamp = Date().timeIntervalSince1970
    var hash: String {
        let digest = Insecure.MD5.hash(data: "\(timeStamp)\(privateApiKey)\(apiKey)".data(using: .utf8) ?? Data())
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}

struct  MarvelAPI {
    let client: HTTPClient
    let security: Security
    init(client: HTTPClient = HTTPClient(), security: Security = Security()) {
        self.client = client
        self.security = security
    }
    let base = "https://gateway.marvel.com:443/v1/public/"
    var baseURL: URL {
        let queryItems = [URLQueryItem(name: "apikey", value: security.apiKey),
                          URLQueryItem(name: "ts", value: "\(security.timeStamp)"),
                          URLQueryItem(name: "hash", value: security.hash)]
        var urlComps = URLComponents(string: base)
        urlComps?.queryItems = queryItems
        guard let baseURL = urlComps?.url else {
            fatalError("Unconstructable URL: \(base)")
        }
        return baseURL
    }
}

extension MarvelAPI {

    func characters() -> AnyPublisher<[Character], Error> {
        return run(URLRequest(url: baseURL.appendingPathComponent("characters")))
    }

    private func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<[T], Error> {
        return client.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

}
