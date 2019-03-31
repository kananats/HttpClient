//
//  RequestProtocol.swift
//  HTTPClient
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import RxSwift
import Alamofire

fileprivate let endpoint = Endpoint()

protocol RequestProtocol {
    
    associatedtype Data: Codable
    
    func request() -> Single<Data>
}

extension RequestProtocol {
    
    func request(api: URLConvertible, method: HTTPMethod) -> Single<Data> {
        return .create { observer in
            endpoint.request(api: api, method: method) { response in
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
