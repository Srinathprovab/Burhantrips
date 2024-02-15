//
//  LongEmptyTVCell.swift
//  Travrun
//
//  Created by MA1882 on 21/12/23.
//

import UIKit

class LongEmptyTVCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
