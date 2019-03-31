//
//  Endpoint.swift
//  HTTPClient
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import Alamofire

let endpoint = MockEndpoint()

protocol EndpointProtocol {
    
    func request(api: URLConvertible, method: HTTPMethod, parameters: Parameters?, completion: @escaping (DataResponse<Any>) -> ())
}

final class Endpoint: EndpointProtocol {
    
    private let baseUrl = "https://reqres.in/"
    
    func request(api: URLConvertible, method: HTTPMethod, parameters: Parameters?, completion: @escaping (DataResponse<Any>) -> ()) {
        AF.request("\(baseUrl)\(api)", method: method, parameters: parameters)
            .responseJSON(completionHandler: completion)
    }
}

final class MockEndpoint: EndpointProtocol {
    
    func request(api: URLConvertible, method: HTTPMethod, parameters: Parameters?, completion: @escaping (DataResponse<Any>) -> ()) {
        let json = self.makeJson(api: try! api.asURL().absoluteString)
        
        self.request(json: json, completion: completion)
    }
}

private extension MockEndpoint {
    
    func request(json: String, completion: @escaping (DataResponse<Any>) -> ()) {
        let data = json.data(using: .utf8)
        let response = DataResponse<Any>(request: nil, response: nil, data: data, metrics: nil, serializationDuration: 0, result: .success(0))
        completion(response)
    }
    
    func makeJson(api: String) -> String {
        switch api {
        case "api/users":
            return MockEndpoint.api_users
        case _ where api.hasPrefix("api/users/"):
            return MockEndpoint.api_users_id
        default:
            fatalError()
        }
    }
    
    static let api_users = """
        {"page":1,"per_page":3,"total":12,"total_pages":4,"data":[{"id":1,"first_name":"George","last_name":"Bluth","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg"},{"id":2,"first_name":"Janet","last_name":"Weaver","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"},{"id":3,"first_name":"Emma","last_name":"Wong","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg"}]}
        """
    
    static let api_users_id = """
        {"data":{"id":2,"first_name":"Janet","last_name":"Weaver","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"}}
        """
}
