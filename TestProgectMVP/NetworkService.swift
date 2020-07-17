//
//  NetworkService.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 17.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData(complition: @escaping(Result<[DataModel]?, Error>)->Void)
}

class NetworkService: NetworkServiceProtocol {
    func getData(complition: @escaping (Result<[DataModel]?, Error>) -> Void) {
        let urlString = "https://pryaniky.com/static/json/sample.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let err = error {
                complition(.failure(err))
                return
            }
            
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    print(json)
                }
            }
        }.resume()
    }
}
