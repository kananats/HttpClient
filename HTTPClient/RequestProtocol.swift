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
    
    func request(api: String) -> Single<Data> {
        return .create { observer in
            endpoint.request(api: api) { response in
                guard case .success(_) = response.result,
                    let json = response.data,
                    let data = try? JSONDecoder().decode(Data.self, from: json) else {
                        return
                }

                observer(.success(data))
            }
            return Disposables.create()
        }
    }
}
