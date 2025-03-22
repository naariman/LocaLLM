//
//  NetworkService.swift
//  LocaLLM
//
//  Created by rbkusser on 01.03.2025.
//

import Foundation
import os.log

enum NetworkError: Error {
    case urlError
    case encodingError
    case decodingError
    case badRequest
    case serverError
    case unknown(message: String?)

    static func error(from statusCode: Int) -> NetworkError? {
        switch statusCode {
        case 200..<300: return nil
        case 400..<500: return .badRequest
        case 500..<600: return .serverError
        default: return .unknown(message: "Unexpected status code: \(statusCode)")
        }
    }

    var localizedDescription: String {
        switch self {
        case .urlError: return "Invalid URL provided"
        case .encodingError: return "Failed to encode request data"
        case .decodingError: return "Failed to decode response data"
        case .badRequest: return "Bad request (4xx error)"
        case .serverError: return "Server error (5xx error)"
        case let .unknown(message): return "Unknown error: \(message ?? "No details available")"
        }
    }
}

enum NetworkMethod: String {
    case GET, POST, PUT, DELETE, PATCH
}

struct NetworkLogger {

    private static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.app.networking", category: "NetworkService")

    static func log(request: URLRequest) {
        let method = request.httpMethod ?? "unknown"
        let url = request.url?.absoluteString ?? "unknown"

        var logMessage = "➡️ \(method) \(url)"

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            logMessage += "\nHeaders: \(headers)"
        }

        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            logMessage += "\nBody: \(bodyString)"
        }

        logger.info("\(logMessage)")
    }

    static func log(response: HTTPURLResponse, data: Data?) {
        let url = response.url?.absoluteString ?? "unknown"
        let statusCode = response.statusCode

        var logMessage = "⬅️ [\(statusCode)] \(url)"

        if let data = data, let responseString = String(data: data, encoding: .utf8) {
            logMessage += "\nResponse: \(responseString)"
        }

        if statusCode >= 400 {
            logger.error("\(logMessage)")
        } else {
            logger.info("\(logMessage)")
        }
    }

    static func log(error: Error) {
        logger.error("❌ Network Error: \(error.localizedDescription)")
    }
}

struct NetworkService {

    func request<T: Decodable>(
        urlString: String?,
        body: Encodable? = nil,
        method: NetworkMethod = .GET,
        headers: [String: String]? = nil
    ) async throws -> T {
        guard let urlString, let url = URL(string: urlString) else {
            NetworkLogger.log(error: NetworkError.urlError)
            throw NetworkError.urlError
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                NetworkLogger.log(error: NetworkError.encodingError)
                throw NetworkError.encodingError
            }
        }

        NetworkLogger.log(request: request)

        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)

            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                let error = NetworkError.unknown(message: "Invalid response type")
                NetworkLogger.log(error: error)
                throw error
            }

            NetworkLogger.log(response: httpResponse, data: data)

            if let error = NetworkError.error(from: httpResponse.statusCode) {
                NetworkLogger.log(error: error)
                throw error
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                NetworkLogger.log(error: NetworkError.decodingError)
                throw NetworkError.decodingError
            }
        } catch let networkError as NetworkError {
            throw networkError
        } catch {
            let wrappedError = NetworkError.unknown(message: error.localizedDescription)
            NetworkLogger.log(error: wrappedError)
            throw wrappedError
        }
    }

    func requestWithStream<T: Decodable>(
        urlString: String?,
        body: Encodable? = nil,
        method: NetworkMethod = .GET,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let urlString, let url = URL(string: urlString) else {
            NetworkLogger.log(error: NetworkError.urlError)
            completion(.failure(.urlError))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        if let body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                NetworkLogger.log(error: NetworkError.encodingError)
                completion(.failure(.encodingError))
                return
            }
        }

        NetworkLogger.log(request: request)

        Task {
            do {
                let (stream, urlResponse) = try await URLSession.shared.bytes(for: request)

                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    let error = NetworkError.unknown(message: "Invalid response type")
                    NetworkLogger.log(error: error)
                    completion(.failure(error))
                    return
                }

                NetworkLogger.log(response: httpResponse, data: nil)

                if let error = NetworkError.error(from: httpResponse.statusCode) {
                    NetworkLogger.log(error: error)
                    completion(.failure(error))
                    return
                }

                for try await line in stream.lines {
                    if let data = line.data(using: .utf8) {
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(decodedData))
                        } catch {
                            NetworkLogger.log(error: NetworkError.decodingError)
                            completion(.failure(.decodingError))
                        }
                    }
                }
            } catch let networkError as NetworkError {
                NetworkLogger.log(error: networkError)
                completion(.failure(networkError))
            } catch {
                let wrappedError = NetworkError.unknown(message: error.localizedDescription)
                NetworkLogger.log(error: wrappedError)
                completion(.failure(wrappedError))
            }
        }
    }
}
