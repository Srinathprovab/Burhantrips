//
//  TabSelectCVCell.swift
//  BabSafar
//
//  Created by FCI on 17/11/22.
//

import UIKit

class TabSelectCVCell: UICollectionViewCell {

    
    
    @IBOutlet weak var middleSpace: NSLayoutConstraint!
    @IBOutlet weak var heightOfimage: NSLayoutConstraint!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var widthofImage: NSLayoutConstraint!
    
    var imageStr = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        holderView.addCornerRadiusWithShadow(color: .buttonBGColor ?? .blue , borderColor: .clear, cornerRadius: 6)
        contentView.layer.cornerRadius = 5
        holderView.layer.cornerRadius = 6
        holderView.backgroundColor = .white
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setuplabels(lbl: titlelbl, text: "", textcolor: HexColor("#3C627A"), font: UIFont.InterSemiBold(size: 16), align: .center)
    }
    
    
    
    func selected() {
//        holderView.backgroundColor = .AppTabSelectColor
        img.image = UIImage(named: imageStr)?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
    }
    
    
    func unselected() {
        holderView.backgroundColor = .WhiteColor
        img.image = UIImage(named: imageStr)?.withRenderingMode(.alwaysOriginal).withTintColor(.ImageUnSelectColor)
    }
    
 

}
