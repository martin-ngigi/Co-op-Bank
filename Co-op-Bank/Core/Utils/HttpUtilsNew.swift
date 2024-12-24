//
//  HttpUtilsNew.swift
//  Co-op-Bank
//
//  Created by Martin Wainaina on 24/12/2024.
//

import Foundation

class HttpUtilsNew {
    static let shared = HttpUtilsNew()

    func secureRequestAPI<T: Encodable>(
        url: URL,
        httpMethod: HttpMethod,
        postData: T? = Optional<Data>.none,
        isAccessTokenNeeded: Bool = true,
        enableLoading: Bool = false,
        retryRequest: Bool = false,
        rescueRequest: Bool = true
    ) async -> (Data?, URLResponse?){
        do {
            // Enable loading indicator
            if enableLoading {
                Task {
                    // Implement your loading indicator logic here
                }
            }
            
            // Prepare the request
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod.getMethod
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.timeoutInterval = Constants.timeoutInterval
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Get access token and device and channelId
            let accessToken = Constants.accessToken
            let deviceID = Constants.deviceId
            
            // Set headers
            if isAccessTokenNeeded {
                request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            request.addValue(deviceID, forHTTPHeaderField: "deviceId")
            
            // Set the request body if it's a POST request and postData is provided
            if httpMethod.getMethod == "POST" {
                if let postData = postData {
                    let jsonData = try JSONEncoder().encode(postData)
                    request.httpBody = jsonData
                } else {

                    request.httpBody = Data()
                }
            }

            
            if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                print("DEBUG: Request Body: \(bodyString)")
            }
            
            return try await self.retry(times: 3, isRetry: retryRequest) {
                // Print the request for debugging
                print("DEBUG: ----------------------------------------------------------------------------------")
                print("DEBUG: Request URL: Time: \(Date()), \(request.url?.absoluteString ?? "nil")")
                print("DEBUG: Request Method: \(request.httpMethod ?? "nil")")
                print("DEBUG: Request Headers: \(request.allHTTPHeaderFields ?? [:])")
                print("DEBUG: ----------------------------------------------------------------------------------")
                
                // Enable HTTP network/traffic logging
                //Experimental.URLSessionProxy.shared.isEnabled = true
                // Perform the network request
                let (data, response) = try await URLSession.shared.data(for: request)
                
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("DEBUG: ----------------------------------------------------------------------------------")
                        print("DEBUG: Raw Response: \(responseString)")
                        print("DEBUG: ----------------------------------------------------------------------------------")
                    } else {
                        print("DEBUG: ----------------------------------------------------------------------------------")
                        print("DEBUG: Raw Response: \(data)")
                        print("DEBUG: ----------------------------------------------------------------------------------")
                    }
                
                return (responseData: data, response: response)
            }

            //return (responseData, response)
            
        }
        catch {
            if error.localizedDescription.contains("network connection was lost"){
                //NetworkMonitor.shared.isConnected = false
            }
            print("DEBUG: API ERROR occurred. Error is \(error.localizedDescription)")
            return (nil, nil)
        }
    }
    

    func retry(
        times: Int = 3,
        initialDelay: TimeInterval = 1.0,
        maxDelay: TimeInterval = 10.0,
        factor: Double = 2.0,
        isRetry: Bool = false,
        block: @escaping () async throws -> (responseData: Data, response: URLResponse)
    ) async throws -> (responseData: Data, response: URLResponse)  {
        var currentDelay = initialDelay
     
        if isRetry {
            for attempt in 0..<times {
                do {
                    let (responseData, response) = try await block()
                    
                    if let httpResponse = response as? HTTPURLResponse, 400 == httpResponse.statusCode {
                        print("DEBUG: RETRYING request status \(httpResponse.statusCode) attempt: \(attempt + 1)")
                    }
//                    else if let responseString = String(data: responseData, encoding: .utf8), responseString.isEmpty {
//                        print("DEBUG: RETRYING request empty response body attempt.: \(attempt + 1)")
//                    }
//                    else if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any], json["Data"] == nil {
//                        print("DEBUG: RETRYING request empty response body attempt..: \(attempt + 1)")
//                    }
//                    else if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Int], json["statusCode"] == 400 {
//                        print("DEBUG: RETRYING request empty response body attempt...: \(attempt + 1)")
//                    }
                    else {
                        //print("DEBUG: RETURNING Response status \(response) attempt: \(attempt + 1)")
                        print("DEBUG: RETURNING Not Retrying attempt: \(attempt + 1)")
                        return (responseData, response)
                    }
                } catch let error as URLError {
                    print("DEBUG: timeout exception, attempt: \(attempt + 1)")
                    // Check if the exception is a specific one that you want to retry on
                    if let httpResponse = error.networkUnavailableReason {
                        print("DEBUG: Retrying due to 400 response, attempt: \(attempt + 1)")
                    } else {
                        throw error // Rethrow the exception if it's not the specific one
                    }
                } catch {
                    throw error
                }
                
                if attempt < times - 1 {
                    try await Task.sleep(nanoseconds: UInt64(currentDelay * Double(NSEC_PER_SEC)))
                    currentDelay = min(currentDelay * factor, maxDelay)
                }
            }
        }
     
        return try await block()
    }
}

enum HttpMethod: String {
    case Post
    case Get
    
    var getMethod: String {
        switch self {
        case .Post:
            return "POST"
        case .Get:
            return "GET"
        }
    }
}
