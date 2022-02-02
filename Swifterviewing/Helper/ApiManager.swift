//
//  ApiManager.swift

//
//  Created by Nazish Ali on 02/02/22.
//  Copyright © 2022 Nazish Ali. All rights reserved.
//

import Foundation

struct ServerURLString {
    static let baseUrl = "https://jsonplaceholder.typicode.com"
}

struct SubstringUrl {
    static let photosEndpoint = "/photos" //returns photos and their album ID
    static let albumsEndpoint = "/albums"
}

enum HTTPRequestType {
    case get
    case post
    
    var getString: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

enum HTTPRequestResult {
    case success(Any)
    case failure(Error)
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Any? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

typealias HTTPRequestHandler = (_ result: HTTPRequestResult) -> Void

class HTTPRequest: NSObject {
    
    var completionHandler: HTTPRequestHandler?
    
    var baseURL: String {
        return ServerURLString.baseUrl
    }
    
    private var headers = [String: String]()
    
    override init() {
        
    }
    
    // MARK: - Public methods
    
    func headers(headers: [String: String]) -> HTTPRequest {
        self.headers.appendDictionary(new: headers)
        return self
    }
    
    
    func sendRequestToServer(param: [String: Any], requestType: HTTPRequestType, urlString: String, completion: @escaping HTTPRequestHandler) {
        
        self.completionHandler = completion
        
       // let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self as URLSessionDelegate, delegateQueue: OperationQueue.main)
        
        guard let _ = URL(string: "\(baseURL)\(urlString)") else {
            return
        }
        
        
        
        var urlRequest = self.addHeaderFieldToUrlRequest(urlString: urlString)
       
        switch requestType {
        case .get:
            urlRequest.httpMethod = requestType.getString
            break
        case .post:
            let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)
            urlRequest.httpMethod = requestType.getString
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
            break
        }
        
        print(self.headers)
        
       // let dataTask = urlSession.dataTask(with: urlRequest)
       // dataTask.resume()
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                let output = try? JSONSerialization.jsonObject(with: data ?? Data(), options: .mutableContainers)
                // print(output)
                 DispatchQueue.main.async {
                   self.completionHandler?(HTTPRequestResult.success(output!))
                }
            } else {
                 DispatchQueue.main.async {
                  self.completionHandler?(HTTPRequestResult.failure(error!))
                }
            }
        }
        .resume()
    }
    
    // MARK: - Private functions
    
    private func addHeaderFieldToUrlRequest(urlString: String ) -> URLRequest {
        
        guard let url = URL(string: "\(baseURL)\(urlString)") else {
            fatalError("url load problem")
        }
        var urlRequest = URLRequest(url: url)
       
        for (key, value) in self.headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
}

extension HTTPRequest: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        print(data)
        
        let output = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        // print(output)
        self.completionHandler?(HTTPRequestResult.success(output))
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(task)
        if error != nil {
            print(error!)
            self.completionHandler?(HTTPRequestResult.failure(error!))
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print(task)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print(response)
        //  print(response.mimeType)
        completionHandler(.allow)
    }
    
}
