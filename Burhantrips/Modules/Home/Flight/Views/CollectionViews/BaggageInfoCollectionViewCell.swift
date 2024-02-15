//
//  BaggageInfoCollectionViewCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class BaggageInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var baggageInfoLabel: UILabel!
    @IBOutlet weak var numberOfPieceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
