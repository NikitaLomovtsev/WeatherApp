//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Никита Ломовцев on 23.09.2021.
//

import Foundation

protocol NetworkManagerProtocol{
    func getWeather(coordinates: String, completion: @escaping (WeatherResponse?) -> Void)
}

struct NetworkManager: NetworkManagerProtocol{
    func getWeather(coordinates: String, completion: @escaping (WeatherResponse?) -> Void) {
    let fullUrl = "\(API.url)\(coordinates)"
        guard let url = URL(string: fullUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decoded = self.decodeJSON(type: WeatherResponse.self, from: data)
            completion(decoded)
        }
        .resume()
    }
    
    
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
