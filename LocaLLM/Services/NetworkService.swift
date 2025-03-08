//
//  NetworkService.swift
//  LocaLLM
//
//  Created by rbkusser on 01.03.2025.
//

import Foundation

enum NetworkError: Error {

    case urlError
    case encodingError
    case decodingError
    case badRequest
    case serverError
    case unknown(message: String?)

    static func error(by statusCode: Int) -> NetworkError? {
        switch statusCode {
        case (200...299):
            return nil
        case (400...499):
            return .badRequest
        case (500...599):
            return .serverError
        default:
            return .unknown(message: "Unexpected status code: \(statusCode)")
        }
    }
}

enum NetworkMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}

struct NetworkService {

    func request<T: Decodable>(
        urlString: String?,
        body: Encodable? = nil,
        method: NetworkMethod = .GET
    ) async throws(NetworkError) -> T {
        guard let urlString else { throw .urlError }
        guard let url = URL(string: urlString) else { throw .urlError }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        if let body {

            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw NetworkError.encodingError
            }
        }

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)

            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw NetworkError.unknown(message: "Cast error 'urlResponse as? HTTPURLResponse'")
            }

            if let error = NetworkError.error(by: urlResponse.statusCode) {
                throw error
            }

            return try JSONDecoder().decode(T.self, from: data)
        }
        catch let networkError as NetworkError {
            throw networkError
        }
        catch {
            throw NetworkError.unknown(message: error.localizedDescription)
        }
    }
}

//    func request(
//        urlString: String?,
//        body: Encodable? = nil,
//        method: NetworkMethod = .GET
//    ) async throws(NetworkError) {
//        guard let urlString else { throw .urlError }
//        guard let url = URL(string: urlString) else { throw .urlError }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//
//        if let body {
//
//            do {
//                request.httpBody = try JSONEncoder().encode(body)
//            } catch {
//                throw NetworkError.encodingError
//            }
//        }
//
//        do {
//            let (data, urlResponse) = try await URLSession.shared.data(for: request)
//
//            guard let urlResponse = urlResponse as? HTTPURLResponse else {
//                throw NetworkError.unknown(message: "Cast error 'urlResponse as? HTTPURLResponse'")
//            }
//
//            if let error = NetworkError.error(by: urlResponse.statusCode) {
//                throw error
//            }
//        }
//        catch let networkError as NetworkError {
//            throw networkError
//        }
//        catch {
//            throw NetworkError.unknown(message: error.localizedDescription)
//        }
//    }

