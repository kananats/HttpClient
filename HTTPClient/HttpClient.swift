//
//  HttpClient.swift
//  HttpClient
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import RxSwift
import Alamofire

final class HttpClient {
    
    final class GetUser: RequestProtocol {
        
        struct Data: Codable {
            let page: Int
            let per_page: Int
            let total: Int
            let total_pages: Int
            let data: [User]
            
            struct User: Codable {
                let id: Int
                let first_name: String
                let last_name: String
                let avatar: String
            }
        }
        
        func request() -> Single<Data> {
            return request(api: "users?page=1")
        }
    }
}
