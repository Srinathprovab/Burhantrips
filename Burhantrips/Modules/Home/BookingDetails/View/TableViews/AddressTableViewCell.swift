//
//  AddressTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 08/12/23.
//

import UIKit

class AddressTableViewCell: TableViewCell {

    @IBOutlet weak var holderView: BorderedView!
    @IBOutlet weak var countryName: UITextField!
    @IBOutlet weak var countryCodeTxtFld: UITextField!
    @IBOutlet weak var phoneNumberTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        countryCodeTxtFld.setLeftPaddingPoints(10)
        emailTxtFld.setLeftPaddingPoints(10)
        phoneNumberTxtFld.setLeftPaddingPoints(10)
        countryName.setLeftPaddingPoints(10)
        
        holderView.layer.borderWidth = 0.7
        holderView.layer.borderColor = HexColor("#B8B8B8").cgColor
        holderView.layer.cornerRadius = 4
        
        emailTxtFld.layer.borderWidth = 0.7
        emailTxtFld.layer.borderColor = HexColor("#B8B8B8").cgColor
        emailTxtFld.layer.cornerRadius = 4
        // Initialization code
    }
    
    override func updateUI() {
        countryCodeTxtFld.text = pdetails?.country_code
        countryName.text = pdetails?.city_name
        phoneNumberTxtFld.text = pdetails?.phone
        emailTxtFld.text = pdetails?.email
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
