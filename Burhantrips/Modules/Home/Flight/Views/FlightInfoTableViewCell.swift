//
//  FlightInfoTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class FlightInfoTableViewCell: TableViewCell {

    @IBOutlet weak var flightNameLbl: UILabel!
    @IBOutlet weak var AirwaysImg1: UIImageView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var departureReturnLabel: UILabel!
    @IBOutlet weak var destinationCodeLabel: UILabel!
    @IBOutlet weak var toCodeLabel: UILabel!
    @IBOutlet weak var bagWait: UILabel!
    @IBOutlet weak var lugaugeWait: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var cityTolbl: UILabel!
    @IBOutlet weak var arivalTime: UILabel!
    @IBOutlet weak var airportlbl: UILabel!
    @IBOutlet weak var terminal1lbl: UILabel!
    @IBOutlet weak var destTime: UILabel!
    @IBOutlet weak var destDate: UILabel!
    @IBOutlet weak var destlbl: UILabel!
    @IBOutlet weak var destTerminal1lbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var hourlbl1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorView.isHidden = true
        infoImage.isHidden = true
        AirwaysImg1.layer.borderColor = HexColor("#DDDDDD").cgColor
        AirwaysImg1.layer.borderWidth = 1
        AirwaysImg1.layer.cornerRadius = AirwaysImg1.layer.frame.width / 2
    }
    
    
    override func updateUI() {
//        if cellInfo?.key == "hide" {
//            separatorView.isHidden = true
//            middleView.isHidden = true
//            bottomView.isHidden = true
//        } else  if cellInfo?.key == "show"{
//            bottomView.isHidden = false
//        } else {
//            bottomLabel.textColor = HexColor("#000000")
//            bottomLabel.font = .InterRegular(size: 12)
//            bottomLabel.text = "Arrival flight in different day"
//            infoImage.isHidden = false
//            bottomLabel.textAlignment = .left
//        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
