//
//  RatingCollectionViewCell.swift
//  Travrun
//
//  Created by MA1882 on 20/12/23.
//

import UIKit

class RatingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var starImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.backgroundColor = .white
        starImage.image = UIImage(named: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        countLabel.textColor = .AppLabelColor
        // Initialization code
    }

}
