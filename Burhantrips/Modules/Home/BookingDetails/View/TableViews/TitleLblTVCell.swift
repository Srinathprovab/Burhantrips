//
//  TitleLblTVCell.swift
//  BeeoonsApp
//
//  Created by MA673 on 17/08/22.
//

import UIKit
protocol TitleLblTVCellDelegate {
    func didTapOnEditBtn(cell:TitleLblTVCell)
}

class TitleLblTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editlbl: UILabel!
    @IBOutlet weak var editImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var holderViewLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var holderViewRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titlelblLeftConstraint: NSLayoutConstraint!
    var travellerId = String()
    var delegate:TitleLblTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .InterRegular(size: 16), align: .left)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .InterRegular(size: 14), align: .right)
        
        
        editView.isHidden = true
        editView.backgroundColor = .clear
        editlbl.textColor = .AppLabelColor
        editlbl.font = UIFont.InterMedium(size: 16)
        editImg.image = UIImage(named: "edit1")
        editBtn.setTitle("", for: .normal)
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        subtitlelbl.text = cellInfo?.subTitle
        
        if cellInfo?.key == "faresub" {
            titlelbl.font = .InterRegular(size: 14)
        }
        
        if cellInfo?.key == "totalcost" {
            tripcost()
        }
        
        
        if cellInfo?.key == "aboutus" {
            titlelbl.attributedText = cellInfo?.title?.htmlToAttributedString
            titlelblLeftConstraint.constant = 16
            holderViewLeftConstraint.constant = 5
            holderViewRightConstraint.constant = 5
            //  holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 8)
        }
        
        if cellInfo?.key == "bookingDetails" {
            titlelbl.textColor = .AppLabelColor
            titlelbl.font = .InterSemiBold(size: 18)
            editView.isHidden = true
            subtitlelbl.isHidden = true
        }
        
        if cellInfo?.key == "hoteldisc" {
            tripcost()
        }
        
        if cellInfo?.key == "Class"
        {
            titlelbl.textColor = .AppLabelColor
            titlelbl.font = .PoppinsMedium(size: 16)
        }
    }
    
    
    func tripcost() {
        subtitlelbl.isHidden = false
        titlelbl.textColor = HexColor("#00A898")
        subtitlelbl.textColor = HexColor("#00A898")
        titlelbl.font = .InterBold(size: 18)
        subtitlelbl.font = .InterBold(size: 18)
        holderView.backgroundColor = .WhiteColor
        holderViewLeftConstraint.constant = 10
        holderViewRightConstraint.constant = 10
    }
    
    func fare() {
        subtitlelbl.isHidden = false
        titlelbl.textColor = .AppLabelColor
    }
    
    
    @IBAction func didTapOnEditBtn(_ sender: Any) {
        delegate?.didTapOnEditBtn(cell: self)
    }
}
