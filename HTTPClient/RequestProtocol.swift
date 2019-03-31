//
//  RequestProtocol.swift
//  HTTPClient
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import RxSwift
import Alamofire

protocol RequestProtocol {
    
    associatedtype Data: Codable
    
    var method: HTTPMethod { get }
    
    var parameters: Parameters? { get }
    
    func request() -> Single<Data>
}

extension RequestProtocol {
    
    var method: HTTPMethod { return .get }
    
    var parameters: Parameters? { return nil }
    
    func request(api: URLConvertible) -> Single<Data> {
        return .create { observer in
            endpoint.request(api: api, method: self.method, parameters: self.parameters) { response in
                guard case .success(_) = response.result,
                    let json = response.data else {
                    observer(.error(response.error!))
                    return
                }

                do {
                    let data = try JSONDecoder().decode(Data.self, from: json)
                    observer(.success(data))
                }
                catch {
                    observer(.error(error))
                    return
                }
            }
            return Disposables.create()
        }
    }
}
