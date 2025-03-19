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
        case (200...299): return nil
        case (400...499): return .badRequest
        case (500...599): return .serverError
        default: return .unknown(message: "Unexpected status code: \(statusCode)")
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
    ) async throws -> T {
        guard let urlString, let url = URL(string: urlString) else { throw NetworkError.urlError }

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

    func requestWithStream<T: Decodable>(
        urlString: String?,
        body: Encodable? = nil,
        method: NetworkMethod = .GET,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let urlString, let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(.encodingError))
                return
            }
        }

        Task {
            do {
                let (stream, urlResponse) = try await URLSession.shared.bytes(for: request)
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    completion(.failure(.unknown(message: "Invalid response type")))
                    return
                }
                if let error = NetworkError.error(by: httpResponse.statusCode) {
                    completion(.failure(error))
                    return
                }

                for try await line in stream.lines {
                    if let data = line.data(using: .utf8) {
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(decodedData))
                        } catch {
                            completion(.failure(.decodingError))
                        }
                    }
                }
            } catch let networkError as NetworkError {
                completion(.failure(networkError))
            } catch {
                completion(.failure(.unknown(message: error.localizedDescription)))
            }
        }
    }
}
