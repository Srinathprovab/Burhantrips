//
//  ItineraryAddTVCell.swift
//  BabSafar
//
//  Created by FCI on 18/11/22.
//

import UIKit

class ItineraryAddTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var additneraryTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    var tripstring = String()
    var depFind = Int()
    var fdetais = [FDFlightDetails]()
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
        tripstring = cellInfo?.title ?? ""
        fdetais = cellInfo?.moreData as! [FDFlightDetails]
        tvHeight.constant = CGFloat((fdetais.count * 222))
        additneraryTV.reloadData()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupTV()
    }
    
    
    func setupTV() {
        additneraryTV.register(UINib(nibName: "FlightInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        additneraryTV.delegate = self
        additneraryTV.dataSource = self
        additneraryTV.tableFooterView = UIView()
        additneraryTV.showsVerticalScrollIndicator = false
        additneraryTV.separatorStyle = .none
        additneraryTV.isScrollEnabled = false
    }
    
}




extension ItineraryAddTVCell:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fdetais.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlightInfoTableViewCell {
            
            let data = fdetais[indexPath.row]
            if indexPath.row / 2 == 0 {
                cell.bottomView.isHidden = true
            } else {
                cell.bottomView.isHidden = false
            }
            
            cell.flightNameLbl.text = "\(data.operator_name ?? "") (\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
            cell.toCodeLabel.text = "\(data.origin?.city ?? "") (\(data.origin?.loc ?? ""))"
            cell.destinationCodeLabel.text = "\(data.destination?.city ?? "") (\(data.destination?.loc ?? ""))"
            cell.arivalTime.text = "\(data.origin?.date ?? "") \(data.origin?.time ?? "")"
            cell.airportlbl.text = "\(data.origin?.airport_name ?? "")"
            if data.origin?.terminal == "" {
                cell.terminal1lbl.text = "Terminal: "
            }else {
                cell.terminal1lbl.text = "Terminal: \(data.origin?.terminal ?? "0")"
            }
            
            cell.hourlbl1.text = data.duration
            cell.destTime.text = "\(data.destination?.date ?? "") \(data.destination?.time ?? "") "
            cell.destlbl.text = "\(data.destination?.airport_name ?? "")"
            
            if data.destination?.terminal == "" {
                cell.destTerminal1lbl.text = "Terminal: "
            }else {
                cell.destTerminal1lbl.text = "Terminal: \(data.destination?.terminal ?? "0")"
            }
            
            if tableView.isLast(for: indexPath) {
//                cell.bottomLabel.textColor = HexColor("#000000")
//                cell.bottomLabel.font = .PoppinsRegular(size: 14)
//                cell.bottomLabel.text = "Arrival flight in different day"
//                cell.infoImage.isHidden = false
//                cell.bottomLabel.textAlignment = .left
//                cell.bottomView.isHidden = true
              
            } else  {
                cell.bottomView.isHidden = false
                cell.infoImage.isHidden = false
                cell.bottomLabel.text = "Layover Duration \(data.destination?.city ?? "") (\(data.destination?.loc ?? "")) \(data.layOverDuration ?? "")"
            }
            
            cell.AirwaysImg1.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            if tripstring == "0" {
                cell.departureReturnLabel.text = "Depart"
            }else {
                cell.departureReturnLabel.text = "Return"
            }
            
            c = cell
        }
        return c
    }
    
    
    
}
