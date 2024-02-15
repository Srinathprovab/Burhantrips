//
//  NewFromCityTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 19/01/24.
//

import UIKit

class NewFromCityTVCell: TableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var plainImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    
    
    var citycode = String()
    var cityname = String()
    var id = String()
    var label = String()
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
        
        holderView.backgroundColor = .WhiteColor
//        plainImg.image = UIImage(named: "flight")?.withRenderingMode(.alwaysOriginal).withTintColor(HexColor("#4FA0CA"))
        setuplabels(lbl: titlelbl, text: cellInfo?.title ?? "", textcolor: .AppLabelColor, font: .PoppinsRegular(size: 16), align: .left)

    }
    
    
    
    func setAttributedString(str1:String,str2:String) {
        
        let atter1 = [NSAttributedString.Key.foregroundColor:HexColor("#999898"),NSAttributedString.Key.font:UIFont.PoppinsRegular(size: 13)] as [NSAttributedString.Key : Any]
        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.AppLabelColor,NSAttributedString.Key.font:UIFont.PoppinsRegular(size: 13)] as [NSAttributedString.Key : Any]
        
        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
       
        
        let combination = NSMutableAttributedString()
        combination.append(atterStr1)
        combination.append(atterStr2)
        
        subTitlelbl.attributedText = combination
        
    }
    
}
