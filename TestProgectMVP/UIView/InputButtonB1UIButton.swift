//
//  InputButtonB1UIButton.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 18.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class InputButtonB1UIButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        setStyle()
    }
    
    private func setStyle() {
        let textColor = UIColor.white
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        backgroundColor = .systemGray3
        layer.cornerRadius = 15
        alpha = 0.9
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                alpha = 0.6
                transform = .init(scaleX: 0.9, y: 0.9)
            } else {
                alpha = 0.9
                transform = .init(scaleX: 1, y: 1)
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = .systemGray3
                alpha = 0.9
            } else {
                alpha = 0.6
                backgroundColor = .systemBackground
            }
        }
    }
    
    public func clickError() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x, y: center.y-2)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        shake.fromValue = fromValue
        layer.add(shake, forKey: "position")
    }
}
