//
//  SelectorTableViewCell.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 17.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import UIKit

class SelectorTableViewCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    public var comperirion: ((String, Int) ->())?
    
    public var selectorCellData: SelectorData! {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        segmentController.removeAllSegments()
        for index in 0..<selectorCellData.variants.count {
            let element = selectorCellData.variants[index].text
            segmentController.insertSegment(withTitle: element, at: index, animated: false)
        }
        segmentController.selectedSegmentIndex = selectorCellData.selectedId
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: - @IBAction
    @IBAction func segmentControllerValueChanged(_ sender: Any) {
        comperirion?(segmentController.titleForSegment(at: segmentController.selectedSegmentIndex)!,segmentController.selectedSegmentIndex)
    }
}
