//
//  FareTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 04/12/23.
//

import UIKit

protocol FareTableViewCellDelegate {
    func travInfoButtonTappe(cell: FareTableViewCell)
}

class FareTableViewCell: UITableViewCell {

    @IBOutlet weak var travInfoButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var taxAmountLabel: UILabel!
    @IBOutlet weak var fareAmountLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var isDropOpen = true
    var delegate: FareTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func travInfoButtonTapped(_ sender: Any) {
        delegate?.travInfoButtonTappe(cell: self)
    }
}
