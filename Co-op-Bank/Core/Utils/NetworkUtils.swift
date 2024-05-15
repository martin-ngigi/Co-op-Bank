//
//  NetworkUtils.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation

class NetworkUtils{
    static let shared = NetworkUtils()
    
    func fetch<T: Decodable>(returnType: T.Type, url: URL) async -> Result<T, APIError>{
        do{
            var request = URLRequest(url: url)
            request.timeoutInterval = Constants.timeoutInterval
            
            let bearerToken = Constants.accessToken
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("DEBUG: GET__: \(jsonData)")
            }
            else if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    print("DEBUG: GET__: \(jsonData[0])")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                return .failure(APIError.badResponse((response as? HTTPURLResponse)?.statusCode ?? 0))
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }
        catch let error as URLError
        {
            print("DEBUG: urlSession error \(error.localizedDescription)")
            print("DEBUG: -------------")
            return .failure(APIError.urlSession(error))
        }
        catch let decodingError as DecodingError {
            return .failure(APIError.decoding(decodingError))
        }
        catch {
            return .failure(APIError.custom(error.localizedDescription))
        }
    }
    
    func post<T: Encodable, U: Decodable>(returnType: U.Type, url: URL, postData: T) async -> Result<U, APIError> {
        do {
            var request = URLRequest(url: url)
            request.timeoutInterval = Constants.timeoutInterval
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonData = try JSONEncoder().encode(postData)
            request.httpBody = jsonData
            
            // Add bearer token to the Authorization header
            let bearerToken = Constants.accessToken
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

            let (responseData, response) = try await URLSession.shared.data(for: request)
            
            //print("DEBUG: POST response \(response)")
            //print("DEBUG: POST responseData \(responseData)")
            if let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    print("DEBUG: POST__: \(jsonData)")
            }
            else if let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: Any]] {
                    print("DEBUG: POST__: \(jsonData[0])")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                return .failure(APIError.badResponse((response as? HTTPURLResponse)?.statusCode ?? 0))
            }
            
            let decodedData = try JSONDecoder().decode(U.self, from: responseData)
            return .success(decodedData)
        } catch let error as URLError {
            return .failure(APIError.urlSession(error))
        } catch let decodingError as DecodingError {
            return .failure(APIError.decoding(decodingError))
        } catch {
            return .failure(APIError.custom(error.localizedDescription))
        }
    }
    
}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(using: .utf8)!
        append(data)
    }
}
