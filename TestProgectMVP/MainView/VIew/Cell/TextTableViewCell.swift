//
//  TextTableViewCell.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 17.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak var titleTextLabel: UILabel!
    
    public var textData: TextData! {
        didSet {
            titleTextLabel.text = textData.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
