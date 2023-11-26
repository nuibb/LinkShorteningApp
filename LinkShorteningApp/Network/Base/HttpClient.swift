//
//  HttpClient.swift
//  LinkShorteningApp
//
//  Created by Nurul Islam on 17/1/23.
//

import Foundation

protocol HTTPClient {
    func upload(for url: String) async -> Swift.Result<Bool, RequestError>
    func download(for url: String) async -> Swift.Result<Bool, RequestError>
    func getRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Swift.Result<T, RequestError>
    func postRequest<T1: Decodable, T2: Encodable>(endpoint: Endpoint, payload: T2, responseModel: T1.Type) async -> Swift.Result<T1, RequestError>
}

extension HTTPClient {
    
    func upload(for url: String) async -> Swift.Result<Bool, RequestError> {
        return .failure(.unknown)
    }
    
    func download(for url: String) async -> Swift.Result<Bool, RequestError> {
        return .failure(.unknown)
    }
    
    func getRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Swift.Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        debugPrint(url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request) //.data(from: url)
            return decode(data: data, response: response)
        } catch {
            return .failure(.unknown)
        }
    }
    
    func postRequest<T1: Decodable, T2: Encodable>(endpoint: Endpoint, payload: T2, responseModel: T1.Type) async -> Swift.Result<T1, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        debugPrint(url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let payload = try? encoder.encode(payload) else {
            return .failure(.encode)
        }
        
        debugPrint(String(data: payload, encoding: .utf8) ?? "")
        
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: payload)
            return decode(data: data, response: response)
        } catch {
            return .failure(.unknown)
        }
    }
    
    private func decode<T: Decodable>(data: Data, response: URLResponse) -> Swift.Result<T, RequestError> {
        guard let response = response as? HTTPURLResponse else {
            return .failure(.noResponse)
        }
        debugPrint(response.statusCode)
        switch response.statusCode {
        case 200...299:
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                return .failure(.decode)
            }
            return .success(decodedResponse)
        case 401:
            return .failure(.unauthorized)
        default:
            return .failure(.unexpectedStatusCode)
        }
    }
}

