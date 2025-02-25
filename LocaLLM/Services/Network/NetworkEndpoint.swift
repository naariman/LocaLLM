//
//  NetworkEndpoint.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

protocol NetworkEndpoint {

    var baseUrl: String { get }
    var endpointUrl: String { get }
    var httpMethod: HTTPMethod { get }

    var body: Data? { get }
}
