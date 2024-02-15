//
//  NewBaggageInfoTableViewCell.swift
//  Burhantrips
//
//  Created by MA1882 on 18/01/24.
//

import UIKit

class NewBaggageInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var checkdInLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var baggageLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
