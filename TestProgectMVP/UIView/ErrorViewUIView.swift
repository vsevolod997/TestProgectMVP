//
//  ErrorViewUIView.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 18.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class ErrorViewUIView: UIView {

    static let notificationReload = Notification.Name("reloadData")
    
    
    public init(frame: CGRect, error: String) {
        super.init(frame: frame)
        
        setupBackground()
        createSubView(mess: error)
        createReloadButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    fileprivate func setupBackground() {
        backgroundColor = .systemBackground
    }
    
    fileprivate func createSubView(mess: String) {
        let label = UILabel()
        label.text = "Не удалось загрузить данные, возможно отсутствует интернет соединение. Ошибка: " + mess
        label.textAlignment = .center
        label.numberOfLines = 4
        let widthLabel = 400
        let startX = self.center.x - CGFloat(widthLabel/2)
        label.frame = CGRect(x: Int(startX), y: 150, width: widthLabel, height: 150)
        self.addSubview(label)
    }
    
    fileprivate func createReloadButton() {
        let button = InputButtonB1UIButton()
        button.setTitle("Перезагрузить", for: .normal)
        button.frame = CGRect(x: self.frame.width/2.0 - 100, y: self.center.y, width: 200.0, height: 40)
        self.addSubview(button)
        button.addTarget(self, action: #selector(reloadButtonPress), for: .touchUpInside)
    }
    
    @objc func reloadButtonPress() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        NotificationCenter.default.post(name: ErrorViewUIView.notificationReload, object: nil,  userInfo: nil)
    }
    
}
