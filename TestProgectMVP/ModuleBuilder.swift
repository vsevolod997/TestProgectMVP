//
//  ModuleBuilder.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 16.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import UIKit

//MARK: - protocol to create all view
protocol Builder {
    static func showMainView() -> UIViewController
}

class ModelBuilder: Builder {
    
    static func showMainView() -> UIViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let view = sb.instantiateViewController(identifier: "mainVC") as? MainViewController else { return UIViewController() }
        let networkService = NetworkService()
    
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        view.presenter.getData()
        
        return view
    }
}
