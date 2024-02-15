//
//  SortTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 29/11/23.
//

import UIKit

class SortTableViewCell: TableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftBuuton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func updateUI() {
        titleLabel.text = cellInfo?.title
        if cellInfo?.key == "Price" {
            leftLabel.text = "Low to high"
            rightLabel.text = "Hight to low"
        }  else {
            leftLabel.text = "Earlist  flight"
            rightLabel.text = "Latest flight"
        }
    }
    
}
