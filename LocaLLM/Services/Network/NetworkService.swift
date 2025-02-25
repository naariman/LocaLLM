//
//  NetworkService.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

struct User: Decodable {
     var name = ""
}

class NetworkService {

    func request<T: Decodable>(_ endpoint: NetworkEndpoint) async throws(NetworkError) -> T? {
        do {
            let urlString = endpoint.baseUrl + endpoint.endpointUrl
            guard let url = URL(string: urlString) else {
                throw NetworkError.invalidUrl
            }

            var request = URLRequest(url: url)
            request.httpMethod = endpoint.httpMethod.rawValue

            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            if let body = endpoint.body {
                let jsonData = try JSONEncoder().encode(body)
                request.httpBody = jsonData
            }

            let (data, response) = try await URLSession.shared.data(for: request)

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                throw NetworkError.invalidStatusCode(statusCode: -1)
            }

            guard (200...299).contains(statusCode) else {
                throw NetworkError.invalidStatusCode(statusCode: statusCode)
            }

            return try JSONDecoder().decode(T.self, from: data)
        }
        catch let error as DecodingError {
            throw .decodingFailed(innerError: error)
        } catch let error as EncodingError {
            throw .encodingFailed(innerError: error)
        } catch let error as URLError {
            throw .requestFailed(innerError: error)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .otherError(innerError: error)
        }
    }
}
