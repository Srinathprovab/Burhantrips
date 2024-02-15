//
//  AboutusTVCell.swift
//  QBBYTravelApp
//
//  Created by FCI on 03/01/23.
//

import UIKit

protocol AboutusTVCellDelegate {
    func didTapOnAboutUsLink(cell:AboutusTVCell)
    func didTapOnTermsLink(cell:AboutusTVCell)
    func didTapOnCoockiesLink(cell:AboutusTVCell)
    func didTapOnContactUs(cell:AboutusTVCell)
}

class AboutusTVCell: TableViewCell {
    
    
    @IBOutlet weak var aboutlbl: UILabel!
    @IBOutlet weak var termslbl: UILabel!
    @IBOutlet weak var cookieslbl: UILabel!
    @IBOutlet weak var contactus: UILabel!
    
    
    var delegate:AboutusTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        
        setAttributedString(lbl: aboutlbl, str1: "About Us")
        setAttributedString(lbl: termslbl, str1: "Terms & Conditions")
        setAttributedString(lbl: cookieslbl, str1: "Privacy Policy")
        setAttributedString(lbl: contactus, str1: "Contact Us")
    }
    
    
    func setAttributedString(lbl:UILabel,str1:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,
                      NSAttributedString.Key.font:UIFont.InterRegular(size: 14),
                      NSAttributedString.Key.underlineStyle:NSUnderlineStyle.thick.rawValue,
                      NSAttributedString.Key.underlineColor:UIColor.AppBtnColor] as [NSAttributedString.Key : Any]
        
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        lbl.attributedText = combination
        
        
        
        switch lbl {
        case aboutlbl:
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapaboutlbl(tap:)))
            lbl.addGestureRecognizer(tap)
            lbl.isUserInteractionEnabled = true
            break
            
        case termslbl:
            let tap = UITapGestureRecognizer(target: self, action: #selector(taptermslbl(tap:)))
            lbl.addGestureRecognizer(tap)
            lbl.isUserInteractionEnabled = true
            break
            
        case cookieslbl:
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapcookieslbl(tap:)))
            lbl.addGestureRecognizer(tap)
            lbl.isUserInteractionEnabled = true
            break
            
            
            
        case contactus:
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapcontactuslbl(tap:)))
            lbl.addGestureRecognizer(tap)
            lbl.isUserInteractionEnabled = true
            break
            
            
        default:
            break
        }
        
    }
    
    
    
    
    @objc func tapaboutlbl(tap: UITapGestureRecognizer) {
        guard let range = self.aboutlbl.text?.range(of: "About Us")?.nsRange else {
            return
        }
        if tap.didTapAttributedTextInLabel(label: self.aboutlbl, inRange: range) {
            delegate?.didTapOnAboutUsLink(cell: self)
        }
    }
    
    
    @objc func taptermslbl(tap: UITapGestureRecognizer) {
        guard let range = self.termslbl.text?.range(of: "Terms & Conditions")?.nsRange else {
            return
        }
        if tap.didTapAttributedTextInLabel(label: self.termslbl, inRange: range) {
            delegate?.didTapOnTermsLink(cell: self)
        }
    }
    
    
    
    @objc func tapcookieslbl(tap: UITapGestureRecognizer) {
        guard let range = self.cookieslbl.text?.range(of: "Privacy Policy")?.nsRange else {
            return
        }
        if tap.didTapAttributedTextInLabel(label: self.cookieslbl, inRange: range) {
            delegate?.didTapOnCoockiesLink(cell: self)
        }
    }
    
    
    @objc func tapcontactuslbl(tap: UITapGestureRecognizer) {
        guard let range = self.contactus.text?.range(of: "Contact Us")?.nsRange else {
            return
        }
        if tap.didTapAttributedTextInLabel(label: self.contactus, inRange: range) {
            delegate?.didTapOnContactUs(cell: self)
        }
    }
    
}
