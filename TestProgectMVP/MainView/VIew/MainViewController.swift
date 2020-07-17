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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.datas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        
        cell.textLabel?.text = presenter.datas?[indexPath.row].data
        return cell
    }
    
}


//MARK: - MainViewSentDataProtocol
extension MainViewController: MainViewSentDataProtocol {
    func setSucsessData() {
        tableView.reloadData()
    }
    
    func setErrorData(error: Error) {
        print(error.localizedDescription)
    }
}
