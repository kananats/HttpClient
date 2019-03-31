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
        
        let api: URLConvertible
        
        let method: HTTPMethod = .get
        
        init(id: Int) {
            self.api = "api/users/\(id)"
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
        
        let api: URLConvertible = "api/users"
        
        let method: HTTPMethod = .get
        
        let parameters: Parameters?

        init() {
            self.parameters = nil
        }
        
        init(page: Int) {
            self.parameters = ["page": page]
        }
    }
    
    final class PostUser: RequestProtocol {
        
        struct Data: Codable {
            let id: String
            let createdAt: String
        }
        
        let api: URLConvertible = "api/users"
        
        let method: HTTPMethod = .post
        
        let parameters: Parameters
        
        init(name: String, job: String) {
            self.parameters = [
                "name": name,
                "job": job
            ]
        }
    }
}
