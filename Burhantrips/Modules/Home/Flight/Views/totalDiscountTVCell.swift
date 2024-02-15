//
//  totalDiscountTVCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class totalDiscountTVCell: TableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var TripTotalLabel: UILabel!
    @IBOutlet weak var fareTotalLabel: UILabel!
    @IBOutlet weak var tripTotalCurrencyType: UILabel!
    @IBOutlet weak var fareCurrencyTypeLbl: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        TripTotalLabel.text = grandTotal
        fareTotalLabel.text = grandTotal
//        fareCurrencyTypeLbl.text = "\(fareCurrencyType)"
//        tripTotalCurrencyType.text = "\(fareCurrencyType )"
    }
    
}
