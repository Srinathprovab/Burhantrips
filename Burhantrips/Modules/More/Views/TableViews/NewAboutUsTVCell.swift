//
//  NewAboutUsTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 06/02/24.
//

import UIKit

class NewAboutUsTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var arrowImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
    }
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .AppGreenColor.withAlphaComponent(0.3), borderColor: .clear, cornerRadius: 6)
        setupLabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .PoppinsRegular(size: 18))
//        arrowImg.image = UIImage(named: "right")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
    }
    
    
//    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
//        v.backgroundColor = color
//        v.layer.cornerRadius = radius
//        v.clipsToBounds = true
//        v.layer.borderWidth = 1
//        v.layer.borderColor = UIColor.AppGreenColor.withAlphaComponent(0.4).cgColor
//    }
//    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
}
