//
//  WebService.swift
//  Vybey-Boi
//
//  Created by Stephen Looney  
//  Copyright 2022 Spaceboat Development, LLC. All rights reserved.  
//

import Foundation

enum HTTPMethod: String {
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
}

enum APIError: Error {
    case generalError
    case missingParameters
}

struct Resource<T> {
    var url: URL
    var params: T? = nil
    var parse: (Data) throws -> T
}

class WebService<T> {

    static func get(resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.method = .GET
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            return try resource.parse(data)
        } catch {
            print(error.localizedDescription)
            throw APIError.generalError
        }
    }
}

extension URLRequest {
    var method: HTTPMethod? {
        set {
            self.httpMethod = newValue?.rawValue
        }
        get {
            return httpMethod != nil ? HTTPMethod(rawValue: self.httpMethod!) : nil
        }
    }
}
