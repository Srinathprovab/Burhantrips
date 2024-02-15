//
//  AddFlightInfoTVCell.swift
//  BabSafar
//
//  Created by FCI on 12/09/23.
//

import UIKit

class AddFlightInfoTVCell: UITableViewCell {
    
    @IBOutlet weak var economyLabel: UILabel!
    @IBOutlet weak var cabinlbl: UILabel!
    @IBOutlet weak var checkinBaggagelbl: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airlinelogo: UIImageView!
    @IBOutlet weak var deplogo: UIImageView!
    @IBOutlet weak var airlinelbl: UILabel!
    @IBOutlet weak var durationlbl: UILabel!
    @IBOutlet weak var noofStopslbl: UILabel!
    @IBOutlet weak var fromTimelbl: UILabel!
    @IBOutlet weak var fromCitylbl: UILabel!
    @IBOutlet weak var toTimelbl: UILabel!
    @IBOutlet weak var toCitylbl: UILabel!
    @IBOutlet weak var ulView: UIView!
    
    @IBOutlet weak var separatorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        airlinelogo.layer.borderWidth = 0.5
        airlinelogo.layer.borderColor = HexColor("#DDDDDD").cgColor
        airlinelogo.layer.cornerRadius = airlinelogo.layer.frame.width / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
