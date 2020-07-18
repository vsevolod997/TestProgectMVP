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
    func showMessage(message: String)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewSentDataProtocol, networkService: NetworkServiceProtocol)
    
    var datas: [ResultModel]? { get set }
    var isDataLoad: Bool {get set}
    
    func getData()
    func selectObject(indexPath: IndexPath)
    func changedSelector(value: String, index: Int)
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewSentDataProtocol?
    
    var isDataLoad: Bool = false
    var datas: [ResultModel]?
    let networkService: NetworkServiceProtocol
    
    required init(view: MainViewSentDataProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        addReloadNotification()
    }
    
    func selectObject(indexPath: IndexPath ) {
        guard let object = self.datas?[indexPath.row] else { return }
        let message = self.createShowMessage(object: object)
        view?.showMessage(message: message)
    }
    
    func changedSelector(value: String, index: Int) {
        let message = "изменео значение селектора на " + value + ".Выбран элемент под номером №" + String(index)
        view?.showMessage(message: message)
    }
    
    func getData() {
        networkService.getData { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.datas = data
                    self.isDataLoad = true
                    self.view?.setSucsessData()
                case .failure(let error):
                    self.view?.setErrorData(error: error)
                }
            }
        }
        
    }
    
    //MARK: - private Method
    
    private func addReloadNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)), name: ErrorViewUIView.notificationReload, object: nil)
    }
    
    @objc func reloadData(notification: Notification) {
        getData()
    }
    
    private func createShowMessage(object: ResultModel) -> String {
           
           var resultString = ""
           
           switch object.type {
           case .image:
               if let value = object.value as? ImageData {
                   resultString =  value.text
               }
           case .text:
               if let value = object.value as? TextData {
                   resultString =  value.text
               }
           case .selector:
               if let value = object.value as? SelectorData {
                   let result = value.variants[value.selectedId].text
                   resultString = result
               }
           }
           return resultString
       }
       
}
