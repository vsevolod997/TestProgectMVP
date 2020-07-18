//
//  ImageTableViewCell.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 17.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak var titleImageLabel: UILabel!
    @IBOutlet weak var icoImageView: UIImageView!
    
    public var imageCellData: ImageData! {
        didSet {
            titleImageLabel.text = imageCellData.text
            loadImage(urlString: imageCellData.url)
        }
    }
    
    private func loadImage(urlString: String) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = URL(string: urlString) else { return }
            if let imageData = try? Data(contentsOf: url ) {
                DispatchQueue.main.async {
                    self.icoImageView.image = UIImage(data: imageData)
                }
            }
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
