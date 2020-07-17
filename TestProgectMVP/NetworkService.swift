//
//  NetworkService.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 17.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getData(complition: @escaping(Result<[ResultModel]?, Error>)->Void)
}

class NetworkService: NetworkServiceProtocol {
    let jsonConverter = JsonParseService()
    
    func getData(complition: @escaping (Result<[ResultModel]?, Error>) -> Void) {
        let urlString = "https://pryaniky.com/static/json/sample.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let err = error {
                complition(.failure(err))
                return
            }
            
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                    let obj = self.jsonConverter.convertJson(json: json)
                    for o in obj {
                        print(o.type, o.value)
                    }
                    complition(.success(obj))
                }
            }
        }.resume()
    }
}
