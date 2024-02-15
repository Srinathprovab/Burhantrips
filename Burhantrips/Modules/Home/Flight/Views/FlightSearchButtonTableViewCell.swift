//
//  FlightSearchButtonTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 17/11/23.
//

import UIKit

protocol FlightSearchButtonTableViewCellDelegate {
    func didTapOnflightSearchBtnAction(cell: FlightSearchButtonTableViewCell)
}

class FlightSearchButtonTableViewCell: TableViewCell {

    @IBOutlet weak var topconstarintOfBtn: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    
    var delegate:FlightSearchButtonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        button.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func flightSearchButtonAction(_ sender: Any) {
        delegate?.didTapOnflightSearchBtnAction(cell: self)
    }
}
