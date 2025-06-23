//
//  EventWatchRestfulAPI.swift
//  Event Watch App
//
//  Created by Duong Tuan on 17/06/2025.
//

import Foundation
import Combine

class EventWatchRestfulAPI: EventWatchAPI {
    
    static let shared = EventWatchRestfulAPI()
    
    private let apiDomain: String = "dummyjson.com"
    private let apiEndPoint: String = "/c/cee5-40b5-4fd8-956d"
    
    /// Returns the assembled URLComponents of the API endpoint.
    lazy private var newsUrlComponents: URLComponents = {
        var components = URLComponents()
            components.scheme = "https"
            components.host = apiDomain
            components.path = apiEndPoint
            components.queryItems = [
                URLQueryItem(name: "api_key", value: "reqres-free-v1")
            ]
        return components
    }()

    /// Unwraps the URL, there's no fallback since the URL is hardcoded.
    lazy private var newsUrl: URL = {
        guard let unwrappedUrl = newsUrlComponents.url else { fatalError("Wrong URL") }
        return unwrappedUrl
    }()
}

extension EventWatchRestfulAPI {
    
    private enum DataError: Error {
        case cantDecode
        case badResponse(response: URLResponse, url: URL)
    }
    
    /// Returns the data from the network call if there are no errors in the response.
    private func checkResponse(dataTaskOutput: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        
        guard let response = dataTaskOutput.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw DataError.badResponse(response: dataTaskOutput.response, url: url)
        }
        if let json = try? JSONSerialization.jsonObject(with: dataTaskOutput.response, options: []) {
            print("📦 JSON object:\n\(json)")
        }
        print(dataTaskOutput)
        return dataTaskOutput.data
    }
    
    /// Gets data from an URL, retries three times in case of network errors.
    func getEvents() -> AnyPublisher<[EventsModel], any Error> {
        let url = EventWatchRestfulAPI.shared.newsUrl
        print(url)
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                try self.checkResponse(dataTaskOutput: $0, url: url)
            }
            .decode(type: [EventsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
}
