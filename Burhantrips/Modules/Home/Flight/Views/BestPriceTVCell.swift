//
//  BestPriceTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 12/01/24.
//

import UIKit

class BestPriceTVCell: TableViewCell {
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        holderView.layer.cornerRadius = 4
//        holderView.layer.borderWidth = 0.5
//        holderView.layer.borderColor = HexColor("#000000").withAlphaComponent(0.2).cgColor
        holderView.addCornerRadiusWithShadow(color: HexColor("#000000").withAlphaComponent(0.2), borderColor: .clear, cornerRadius: 6)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func applyShadowOnView(_ view: UIView) {
//
//    }
    
}
