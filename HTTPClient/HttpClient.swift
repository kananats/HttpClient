//
//  HttpClient.swift
//  HttpClient
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import RxSwift
import Alamofire

final class HttpClient { }

extension HttpClient {

    final class GetUser: RequestProtocol {
        
        struct Data: Codable {
            let data: User
            
            struct User: Codable {
                let id: Int
                let first_name: String
                let last_name: String
                let avatar: String
            }
        }
        
        let method: HTTPMethod = .get
        
        private let id: Int
        
        init(id: Int) {
            self.id = id
        }
        
        func request() -> Single<Data> {
            return self.request(api: "api/users/\(self.id)")
        }
    }
    
    final class GetUsers: RequestProtocol {
        
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
        
        let method: HTTPMethod = .get
        
        let parameters: Parameters?

        init() {
            self.parameters = nil
        }
        
        init(page: Int) {
            self.parameters = ["page": page]
        }
        
        func request() -> Single<Data> {
            return self.request(api: "api/users")
        }
    }
    
    final class PostUser: RequestProtocol {
        
        struct Data: Codable {
            let id: String
            let createdAt: String
        }
        
        let method: HTTPMethod = .post
        
        let parameters: Parameters
        
        init(name: String, job: String) {
            self.parameters = [
                "name": name,
                "job": job
            ]
        }
        
        func request() -> Single<Data> {
            return self.request(api: "api/users/")
        }
    }
}
