//
//  RequestBuilder.swift
//  SolutionX
//
//  Created by Mohamed Sliem on 04/02/2025.
//

import Foundation

class RequestBuilder: RequestBuilderProtocol {
    
    private var request: URLRequest!
    private var endpoint: EndpointProtocol!
    
    func build(_ endpoint: EndpointProtocol, httpMethod: HTTPMethod) throws -> URLRequest {
        self.endpoint = endpoint
        
        var url = try constructURL()
        try setQueryParameters(to: &url)
        
        createRequest(with: url)
        
        setHeaders()
        
        setHTTPMethod(method: httpMethod)
        
        try setBodyIfRequired(method: httpMethod)
        
        return request
    }
    
    private func constructURL() throws(SolutionXException.NetworkError) -> URL {
        let fullURL = endpoint.base + endpoint.path
        guard let url = URL(string: fullURL) else {
            throw .invalidURL
        }
        return url
    }
    
    private func setQueryParameters(to url: inout URL) throws (SolutionXException.NetworkError) {
        guard let queryItems = endpoint.parameters else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems =  queryItems.map({
            return URLQueryItem(name: $0.key, value: $0.value)
        })
    }
    
    private func createRequest(with url: URL) {
        self.request = URLRequest(
            url: url,
            timeoutInterval: endpoint.timeoutInterval
        )
    }
    
    private func setHeaders() {
        self.request.allHTTPHeaderFields = endpoint.headers
    }
    
    private func setHTTPMethod(method: HTTPMethod) {
        self.request.httpMethod = method.rawValue
    }
    
    private func setBodyIfRequired(method: HTTPMethod) throws {
        
        guard method == .post || method == .put else { return }
        
        guard let body = endpoint.body else {
            print("Body is missed for \(method) request")
            throw SolutionXException.networkError(.requestBodyIsMissed)
        }
        
        if let body = body as? [String: Any] {
            try setJsonBody(body)
        } else if let body = body as? Data {
            multipart(for: body)
        }
    }
    
    private func setJsonBody(_ body: [String: Any]) throws {
        do {
            let encodedBody = try JSONSerialization.data(withJSONObject: body)
            self.request.httpBody = encodedBody
        } catch {
            print(error) // for debugging
            throw SolutionXException.networkError(.invalidBody)
        }
    }
}

//MARK: - Multipart Request

extension RequestBuilder {
    func multipart(for body: Data) {}
}
