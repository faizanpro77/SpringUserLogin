//
//  NetworkManager.swift
//  SpringUserLogin
//
//  Created by MD Faizan on 21/07/23.
//

import Foundation


struct LoginParameters: Codable {
    let email: String
    let password: String
}

struct TokenResponse: Codable {
    let token: String
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    func loginWith(email: String, password: String, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let parameters = LoginParameters(email: email, password: password)
        
        guard let url = URL(string: "https://reqres.in/api/login") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
                    completion(.success(tokenResponse))
                } catch(let error) {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "InvalidResponse", code: -1, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    
    
    func getAPIData(completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let url = URL(string: "https://reqres.in/api/login") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let userModel = try decoder.decode(UserModel.self, from: data)
                    completion(.success(userModel))
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                completion(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
            }
        }
        
        task.resume()
    }
}
