//
//  HTTPClient.swift
//  MarvelUI
//
//  Created by Pablo Calcagnino on 08/04/2021.
//

import Foundation
import Combine

public enum APIError: Error {
    case internalError
    case decodingError
    case serverError(code: Int, message: String)
}

struct HTTPClient {

    let session = URLSession.shared

    struct Response<T: Decodable> {
        let value: [T]
        let response: URLResponse
    }

    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError {
                APIError.serverError(code: $0.errorCode, message: $0.localizedDescription)
            }
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(MarvelResponse<T>.self, from: result.data)
                return Response(value: value.data.results, response: result.response)
            }
            .mapError { _ in
                APIError.decodingError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
