//
//  GuestRegisterTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit
import Toast_Swift

class GuestRegisterTableViewCell: TableViewCell {

    @IBOutlet weak var countryCodeTxtFld: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var phoneNumberTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    var email = String()
    var phone = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        emailTxtFld.layer.borderWidth = 0.7
        emailTxtFld.placeholder = "Email Id"
        phoneNumberTxtFld.placeholder = "Phone Number"
        phoneNumberTxtFld.placeholder = "Phone Number"
        
        countryCodeTxtFld.setLeftPaddingPoints(10)
        emailTxtFld.setLeftPaddingPoints(10)
        phoneNumberTxtFld.setLeftPaddingPoints(10)
        emailTxtFld.layer.borderColor = HexColor("#B8B8B8").cgColor
        emailTxtFld.layer.cornerRadius = 4
        continueButton.layer.cornerRadius = 4
        continueButton.backgroundColor =  HexColor("#EE1935").withAlphaComponent(0.3)
        emailTxtFld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
        phoneNumberTxtFld.addTarget(self, action: #selector(textFiledEditingChanged(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        
        if (emailTxtFld.text != nil) && phoneNumberTxtFld.text != ""
        {
    
        } else {
            showToastMsg(message: "Enter the details")
        }
        
    }
    
    func showToastMsg(message: String) {
        var style = ToastStyle()
        style.messageAlignment = .center
        style.backgroundColor = UIColor.black
        style.messageFont = UIFont.latoSemiBold(size: 16)
        style.messageColor = UIColor.WhiteColor
        
        ToastManager.shared.style = style
        ToastManager.shared.position = .bottom
        self.contentView.makeToast(message, duration: 4)
    }
    
    @objc func textFiledEditingChanged(_ textField:UITextField) {
        self.phone = phoneNumberTxtFld.text!
        self.email = emailTxtFld.text!
        if email == "" {
            showToastMsg(message: "Enter Email Adress")
        } else if email.isValidEmail() == false {
            showToastMsg(message: "Enter Valid Email")
        } else if phone == "" {
            showToastMsg(message: "Enter Phone Number")
        } else if phone.isValidMobileNumber() == false {
            showToastMsg(message: "Enter Valid Phone Number")
        } else {
            continueButton.backgroundColor = HexColor("#EE1935")
        }
    }
}
