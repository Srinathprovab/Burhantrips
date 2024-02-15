//
//  FareRulesTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class FareRulesTableViewCell: TableViewCell {

    @IBOutlet weak var ServiceLabel: UILabel!
    @IBOutlet weak var rightDescription: UILabel!
    @IBOutlet weak var leftDescription: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
  
    
    var fareRules: CustomFarerules?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func updateUI() {
        
        fareRules = cellInfo?.moreData as! CustomFarerules?
        
        if cellInfo?.key == "Cancellation Fee" {
//            subTitleLabel.text = fareRules[indexPath].rule_heading
            titleLabel.text = thefareRules?.cancelation_fee?.cancellation_title
            subTitleLabel.text = "\(thefareRules?.cancelation_fee?.origin ?? "" ) - \(thefareRules?.cancelation_fee?.destination ?? "")"
            leftDescription.text = thefareRules?.cancelation_fee?.text_left
            rightDescription.text = thefareRules?.cancelation_fee?.text_right
            ServiceLabel.text = thefareRules?.cancelation_fee?.text_bottom
        } else {
            titleLabel.text = thefareRules?.date_charge_fee?.cancellation_title
            subTitleLabel.text = "\(thefareRules?.date_charge_fee?.origin ?? "" ) - \(thefareRules?.date_charge_fee?.destination ?? "")"
            leftDescription.text = thefareRules?.date_charge_fee?.text_left
            rightDescription.text = thefareRules?.date_charge_fee?.text_right
            ServiceLabel.text = thefareRules?.date_charge_fee?.text_bottom
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
