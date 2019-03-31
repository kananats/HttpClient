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
        
        _ = HttpClient.GetUser(page: 3).request().subscribe(
            onSuccess: { response in
                print("ktr", response.data.first!.first_name)
            },
            onError: { _ in
            }
        )
    }
}
