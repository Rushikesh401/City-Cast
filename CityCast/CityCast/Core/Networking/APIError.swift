//
//  APIError.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error? = nil)
    case decodingFailed(Error)
    case invalidResponse
}
