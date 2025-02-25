//
//  NetworkError.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

enum NetworkError: Error {
    case encodingFailed(innerError: EncodingError)
    case decodingFailed(innerError: DecodingError)
    case invalidStatusCode(statusCode: Int)
    case invalidUrl
    case requestFailed(innerError: URLError)
    case otherError(innerError: Error)
}
