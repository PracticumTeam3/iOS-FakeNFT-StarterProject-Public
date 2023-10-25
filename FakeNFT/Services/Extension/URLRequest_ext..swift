//
//  URLRequest_ext..swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

let defaultBaseURL = URL(string: "https://651ff0bd906e276284c3c180.mockapi.io")!

extension URLRequest {
    static func makeHTTPRequest(
        path:String,
        httpMethod: String,
        baseURL: URL = defaultBaseURL
    ) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL)!)
        request.httpMethod = httpMethod
        return request
    }
    static func makeHTTPRequest(
        path:String,
        baseURL: URL = defaultBaseURL
    ) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL)!)
        return request
    }
}
