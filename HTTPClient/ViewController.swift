//
//  ViewController.swift
//  HTTPClient
//
//  Created by Kananat Suwanviwatana on 2019/03/30.
//  Copyright © 2019 Kananat Suwanviwatana. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        endpoint = Endpoint()
        _ = HttpClient.PostUser(name: "morpheus", job: "leader").request().subscribe(
            onSuccess: { data in
                print("ktr success", data.createdAt)
            },
            onError: { error in
                print("ktr error", error)
            }
        )
    }
}
