//
//  MainPresenter.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 16.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import Foundation


protocol MainViewSentDataProtocol: class {
    func setSucsessData()
    func setErrorData(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewSentDataProtocol, networkService: NetworkServiceProtocol)
    
    func getData()
    var datas: [Any]? { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    weak var view: MainViewSentDataProtocol?
    
    var datas: [Any]?
    let networkService: NetworkServiceProtocol
    
    required init(view: MainViewSentDataProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getData() {
        networkService.getData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.datas = data
                    self.view?.setSucsessData()
                case .failure(let error):
                    self.view?.setErrorData(error: error)
                }
            }
        }
    }
}
