//
//  MainViewController.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 16.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainViewPresenterProtocol!
    
    private var errorVC: ErrorViewUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Private Method
    private func setupView() {
        title = "Данные"
    }

    private func showErrorView(error: String) {
        if errorVC == nil {
            errorVC = ErrorViewUIView(frame: self.view.frame, error: error )
            view.addSubview(errorVC)
        }
    }

    private func removeErrorView() {
        if errorVC != nil {
            errorVC.removeFromSuperview()
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.datas?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if presenter.isDataLoad {
            
            let typeCell = presenter.datas?[indexPath.row].type
        
            switch typeCell {
            case .image:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "imgCell", for: indexPath) as? ImageTableViewCell else { return UITableViewCell() }
                cell.imageCellData = presenter.datas?[indexPath.row].value as? ImageData
                return cell
            case .text:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? TextTableViewCell else {return UITableViewCell() }
                cell.textData = presenter.datas?[indexPath.row].value as? TextData
                return cell
            case .selector:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "selectorCell", for: indexPath) as? SelectorTableViewCell else { return UITableViewCell() }
                cell.selectorCellData = presenter.datas?[indexPath.row].value as? SelectorData
                cell.comperirion = {[weak self] value, index in
                    if let self = self {
                        self.presenter.changedSelector(value: value, index: index)
                    }
                }
                return cell
            case .none:
                break
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectObject(indexPath: indexPath)
    }
}

//MARK: - MainViewSentDataProtocol
extension MainViewController: MainViewSentDataProtocol {
    
    func showMessage(message: String) {
        
        let alert = UIAlertController(title: "Выбран элемент", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        present(alert, animated: true)

    }
    
    func setSucsessData() {
        removeErrorView()
        tableView.reloadData()
    }
    
    func setErrorData(error: Error) {
        showErrorView(error: error.localizedDescription)
    }
}
