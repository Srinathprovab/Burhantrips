//
//  GuestDetailsTVCell.swift
//  Travrun
//
//  Created by MA1882 on 26/12/23.
//

import UIKit

class GuestDetailsTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var lastNameTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        holderView.layer.cornerRadius = 8
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = HexColor("#B8B8B8").cgColor
        
        lastNameTextField.layer.cornerRadius = 4
        lastNameTextField.layer.borderWidth = 1
        lastNameTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
