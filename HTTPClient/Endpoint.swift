//
//  Endpoint.swift
//  HTTPClient
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import Alamofire

protocol EndpointProtocol {
    
    func request(api: String, completion: @escaping (DataResponse<Any>) -> ())
}

final class Endpoint: EndpointProtocol {
    
    private let baseUrl = "https://reqres.in/api/"
    
    func request(api: String, completion: @escaping (DataResponse<Any>) -> ()) {
        AF.request("\(baseUrl)\(api)")
            .responseJSON(completionHandler: completion)
    }
}

final class MockEndpoint: EndpointProtocol {
    
    func request(api: String, completion: @escaping (DataResponse<Any>) -> ()) {
        let json =
        """
{"page":1,"per_page":3,"total":12,"total_pages":4,"data":[{"id":1,"first_name":"George","last_name":"Bluth","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg"},{"id":2,"first_name":"Janet","last_name":"Weaver","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg"},{"id":3,"first_name":"Emma","last_name":"Wong","avatar":"https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg"}]}
"""
        request(json: json, completion: completion)
    }
}

private extension MockEndpoint {
    
    func request(json: String, completion: @escaping (DataResponse<Any>) -> ()) {
        let data = json.data(using: .utf8)
        let response = DataResponse<Any>(request: nil, response: nil, data: data, metrics: nil, serializationDuration: 0, result: .success(0))
        completion(response)
    }
}
