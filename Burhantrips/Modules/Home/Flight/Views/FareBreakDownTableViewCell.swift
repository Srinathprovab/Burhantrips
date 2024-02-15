//
//  FareBreakDownTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class FareBreakDownTableViewCell: TableViewCell {
    
    @IBOutlet weak var fareView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var subtotalnfantLabel: UILabel!
    @IBOutlet weak var subtotalChildLabel: UILabel!
    @IBOutlet weak var subtotalAdultLabel: UILabel!
    @IBOutlet weak var childTax: UILabel!
    @IBOutlet weak var childBaseFareLabel: UILabel!
    @IBOutlet weak var infantBaseFareLabel: UILabel!
    @IBOutlet weak var adultBaseFare: UILabel!
    @IBOutlet weak var infantTotalLabel: UILabel!
    @IBOutlet weak var childTotalLabel: UILabel!
    @IBOutlet weak var adultTotalLabel: UILabel!
    @IBOutlet weak var infantTaxLabel: UILabel!
    @IBOutlet weak var adultTax: UILabel!
    @IBOutlet weak var infantView: UIView!
    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var adultView: UIView!
    @IBOutlet weak var infantCountLabel: UILabel!
    @IBOutlet weak var adultCountLabel: UILabel!
    @IBOutlet weak var childCountLabel: UILabel!
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        fareView.layer.cornerRadius = 4
        fareView.layer.maskedCorners = [.layerMinXMaxYCorner]
        fareView.clipsToBounds = true
        
        holderView.layer.cornerRadius = 4
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = HexColor("#E6E8E7").cgColor
        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
        
        infantCountLabel.text = "\(infantsCount)"
        childCountLabel.text = "\(childCount)"
        adultCountLabel.text = "\(adultsCount)"
        
        adultBaseFare.text = Adults_Base_Price
        childBaseFareLabel.text = Childs_Base_Price
        infantBaseFareLabel.text = Infants_Base_Price
        
        adultTax.text = Adults_Tax_Price
        childTax.text = Childs_Tax_Price
        infantTaxLabel.text = Infants_Tax_Price
        
        adultTotalLabel.text = AdultsTotalPrice
        childTotalLabel.text = ChildTotalPrice
        infantTotalLabel.text = InfantTotalPrice
        
        subtotalAdultLabel.text = AdultsTotalPrice
        subtotalChildLabel.text = ChildTotalPrice
        subtotalnfantLabel.text = InfantTotalPrice
        
        totalCostLabel.text = grandTotal
        
        hideAndShowColm()
    }
    
    func hideAndShowColm() {
        if childCount != 0 {
            childView.isHidden = false
        } else {
            childView.isHidden = true
        }
    
        if infantsCount != 0 {
            infantView.isHidden = false
        } else {
            infantView.isHidden = true
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

