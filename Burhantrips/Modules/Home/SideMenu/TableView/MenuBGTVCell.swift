//
//  MenuBGTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import SDWebImage


protocol MenuBGTVCellDelegate {
    func didTapOnLoginBtn(cell:MenuBGTVCell)
    func didTapOnEditProfileBtn(cell:MenuBGTVCell)
}

class MenuBGTVCell: TableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topConstant: NSLayoutConstraint!
    @IBOutlet weak var bottomConst: NSLayoutConstraint!
    @IBOutlet weak var leftConstrnt: NSLayoutConstraint!
    @IBOutlet weak var btnWidth: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var editProfilelbl: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var editProfileViewHeight: NSLayoutConstraint!
    
    var delegate:MenuBGTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        loginBtn.titleLabel?.font = UIFont.InterMedium(size: 20)
        btnWidth.constant = 100
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        loginBtn.titleLabel?.font = UIFont.InterMedium(size: 20)
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
//            loginBtn.isHidden = false
            loginBtn.isUserInteractionEnabled = false
            titleLabel.text = ("\(pdetails?.first_name ?? pdetails?.email ?? "") \(pdetails?.last_name ?? "")")
            loginBtn.setTitleColor(.AppLabelColor , for: .normal)
            loginBtn.titleLabel?.font = UIFont.InterMedium(size: 20)
            loginBtn.titleLabel?.textAlignment = .left
            editProfileView.isHidden = false
            editProfilelbl.text = "Edit Profile"
            editProfilelbl.textAlignment = .center
            editProfilelbl.font = .InterMedium(size: 14)
            editProfilelbl.textColor = .AppLabelColor
            editProfileView.layer.cornerRadius = 4
            editProfileView.backgroundColor = .AppYellowColor
            btnWidth.constant = 100//            leftConstrnt.constant = 0
            
        } else {
//            bottomConst.constant = 31
//            profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
            editProfileView.isHidden = true
            titleLabel.text = "Login / Signup"
            editProfilelbl.text = "Add Your Details"
            editProfilelbl.textAlignment = .left
            editProfilelbl.textColor = .AppLabelColor
            editProfilelbl.font = UIFont.latoRegular(size: 14)
            editProfileView.backgroundColor = .clear
            loginBtn.isUserInteractionEnabled = true
//            leftConstrnt.constant = 10
            btnWidth.constant = 100
            editProfilelbl.textAlignment = .left
            btnWidth.constant = 130
        }
    }
    
    
    func setupUI() {
//        leftConstrnt.constant = 10
//        bottomConst.constant = 31
//        profileImage.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        profileImage.layer.cornerRadius = profileImage.layer.frame.width / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.WhiteColor.cgColor
        
        editProfileView.isHidden = true
        editProfileBtn.setTitleColor(.AppLabelColor, for: .normal)
        
        editProfileBtn.titleLabel?.font = UIFont.InterRegular(size: 12)
        titleLabel.text = "Login / Signup"
        loginBtn.setTitleColor(.AppLabelColor , for: .normal)
        loginBtn.titleLabel?.font = UIFont.InterMedium(size: 20)
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        
        editProfileView.backgroundColor = .clear
        editProfileView.layer.cornerRadius = 15
        editProfileView.clipsToBounds = true
        editProfilelbl.textAlignment = .left
        editProfilelbl.text = "Add Your Details"
        editProfilelbl.textColor = .AppLabelColor
        editProfilelbl.font = UIFont.InterRegular(size: 14)
        
        //editProfileViewHeight.constant = 0
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
    }
}
