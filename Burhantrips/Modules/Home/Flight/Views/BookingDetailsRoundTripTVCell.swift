//
//  BookingDetailsRoundTripTVCell.swift
//  Travrun
//
//  Created by MA1882 on 19/12/23.
//

//import UIKit
//protocol BookingDetailsRoundTripTVCellDelegate {
//    func didTapOnFlightDetailsBtnAction(cell: BookingDetailsRoundTripTVCell)
//}
//
//class BookingDetailsRoundTripTVCell: TableViewCell, UITableViewDelegate, UITableViewDataSource {
//   
//    
//    @IBOutlet weak var markuppricelbl: UILabel!
//    @IBOutlet weak var pricelbl: UILabel!
//    @IBOutlet weak var faretypelbl: UILabel!
//    @IBOutlet weak var flighTV: UITableView!
//    @IBOutlet weak var tvheight: NSLayoutConstraint!
//    @IBOutlet weak var bottomView: UIView!
//    @IBOutlet weak var moreSimlarOptionlbl: UILabel!
//    @IBOutlet weak var similarBtn: UIButton!
//    @IBOutlet weak var similarimg: UIImageView!
//    
//    var flightSummery = [Summary]()
//    var delegate: BookingDetailsRoundTripTVCellDelegate?
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupTV()
//        // Initialization code
//    }
//    
//    
//    override func updateUI() {
//        setAttributedString1(str1: "\(cellInfo?.buttonTitle ?? ""):", str2: String(format: "%.2f", Double(cellInfo?.title ?? "") ?? 0.0))
//        setAttributedTextnew(str1: cellInfo?.buttonTitle ?? "",
//                             str2: String(format: "%.2f", Double(cellInfo?.price ?? "") ?? 0.0),
//                             lbl: pricelbl,
//                             str1font: UIFont.InterRegular(size: 12),
//                             str2font: UIFont.InterBold(size: 20),
//                             str1Color: .AppLabelColor,
//                             str2Color: HexColor("#EE1935"))
//        
//        faretypelbl.text = cellInfo?.subTitle
//        flightSummery = cellInfo?.moreData as? [Summary] ?? []
//        selectedResult = cellInfo?.text ?? ""
//        displayPrice = cellInfo?.price ?? ""
//        
//        bsource = cellInfo?.bookingsource ?? ""
//        bsourcekey = cellInfo?.bookingsourcekey ?? ""
//        
//        if faretypelbl.text == "Refundable" {
//            faretypelbl.textColor = .white
//        }else {
//            faretypelbl.textColor = HexColor("#F96800")
//        }
//        
//        
//        if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
//            if selectedJourneyType != "oneway" {
//                addReturnView.isHidden = true
//                key = "circle"
//            }
//        }
//        
//        if cellInfo?.key == "similar" {
//            hideSimilarlbl()
//        } else if cellInfo?.key == "booking" {
//            moreSimlarOptionlbl.isHidden = true
//            bookNowButtonView.isHidden = true
//        }
//        
//        if let similarList1 = cellInfo?.data as? [[J_flight_list]] {
//            newsimilarList = similarList1
//            let similarListCount = similarList1.count
//            
//            // Debugging: Print the count of similarList1
//            print("Similar List Count: \(similarListCount)")
//            
//            if similarListCount > 1 {
//                setuplabels(lbl: moreSimlarOptionlbl, text: "More similar options(\(similarListCount))", textcolor: UIColor.WhiteColor, font: UIFont.latoRegular(size: 12), align: .right)
//                showSimilarlbl()
//            } else {
//                hideSimilarlbl()
//            }
//        } else if let similarList1 = cellInfo?.data as? [[MCJ_flight_list]] {
//            newsimilarListMulticity = similarList1
//            let similarListCount = similarList1.count
//            
//            // Debugging: Print the count of similarList1
//            print("Similar List Count: \(similarListCount)")
//            
//            if similarListCount > 1 {
//                setuplabels(lbl: moreSimlarOptionlbl, text: "More similar options(\(similarListCount))", textcolor: .WhiteColor, font: UIFont.latoRegular(size: 14), align: .right)
//                showSimilarlbl()
//            } else {
//                hideSimilarlbl()
//            }
//        } else {
//            hideSimilarlbl() // Handle the case when cellInfo?.data is not a valid [[J_flight_list]]
//        }
//        
//        
//        updateHeight()
//    }
//    
//    
//    func setupUI() {
//        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Bottom left corner, Bottom right corner respectively
//        bottomView.layer.cornerRadius = 10
//        bottomView.clipsToBounds = true
//        
//        hideSimilarlbl()
//        setupTV()
//    }
//    
//    
//    func hideSimilarlbl(){
//        //        bottomView.backgroundColor = .clear
//        //        similarimg.isHidden = true
//        similarBtn.isHidden = true
//        similarimg.isHidden = true
//        moreSimlarOptionlbl.isHidden = true
//    }
//    
//    func showSimilarlbl(){
//        bottomView.backgroundColor = HexColor("3C627A")
//        similarimg.isHidden = false
//        similarBtn.isHidden = false
//        moreSimlarOptionlbl.isHidden = false
//    }
//    
//    func setupTV() {
//        let nib = UINib(nibName: "AddFlightInfoTVCell", bundle: nil)
//        flighTV.register(nib, forCellReuseIdentifier: "cell")
//        flighTV.delegate = self
//        flighTV.dataSource = self
//        flighTV.tableFooterView = UIView()
//        flighTV.separatorStyle = .none
//        flighTV.isScrollEnabled = false
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
//    @IBAction func didTapOnFlightDetailsBtnAction(_ sender: Any) {
//        delegate?.didTapOnFlightDetailsBtnAction(cell: self)
//    }
//}
//
//extension BookingDetailsRoundTripTVCell {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return flightSummery.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var ccell = UITableViewCell()
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddFlightInfoTVCell {
//            cell.selectionStyle = .none
//            
//            let data = flightSummery[indexPath.row]
//            
//            cell.economyLabel.text =  data.cabin_class
//            cell.airlinelogo.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
//            
//            cell.airlinelbl.text = "(\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
//            cell.durationlbl.text = data.duration ?? ""
//            cell.noofStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
//            
//            cell.fromTimelbl.text = data.origin?.time ?? ""
//            cell.fromCitylbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
//            cell.toTimelbl.text = data.destination?.time ?? ""
//            cell.toCitylbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
//            //            cell.deplogo.image = UIImage(named: "dep")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
//            
//            if data.weight_Allowance == "" || data.weight_Allowance == nil {
//                cell.cabinlbl.text = "0Kg"
//                cell.checkinBaggagelbl.text = "0Kg"
//            } else {
//                cell.checkinBaggagelbl.text = convertToDesiredFormat(data.weight_Allowance ?? "")
//                cell.cabinlbl.text = convertToDesiredFormat(data.weight_Allowance ?? "")
//            }
//            
//            cell.separatorLabel.isHidden = true
//            if key == "circle" {
//                cell.separatorLabel.isHidden = false
//                if tableView.isLast(for: indexPath) == true {
//                    cell.separatorLabel.isHidden = true
//    //                    cell.topView.isHidden = true
//                }
//            }
//            
//            ccell = cell
//        }
//        return ccell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//}
//
////
////func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////    return flightSummery.count
////}
////
////
////func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////    var ccell = UITableViewCell()
////    if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddFlightInfoTVCell {
////        cell.selectionStyle = .none
////        
////        let data = flightSummery[indexPath.row]
////        
////        cell.economyLabel.text =  data.cabin_class
////        cell.airlinelogo.sd_setImage(with: URL(string: data.operator_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
////        
////        cell.airlinelbl.text = "(\(data.operator_code ?? "")-\(data.flight_number ?? ""))"
////        cell.durationlbl.text = data.duration ?? ""
////        cell.noofStopslbl.text = "\(data.no_of_stops ?? 0) Stops"
////        
////        cell.fromTimelbl.text = data.origin?.time ?? ""
////        cell.fromCitylbl.text = "\(data.origin?.city ?? "")(\(data.origin?.loc ?? ""))"
////        cell.toTimelbl.text = data.destination?.time ?? ""
////        cell.toCitylbl.text = "\(data.destination?.city ?? "")(\(data.destination?.loc ?? ""))"
////        //            cell.deplogo.image = UIImage(named: "dep")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppBtnColor)
////        
////        if data.weight_Allowance == "" || data.weight_Allowance == nil {
////            cell.cabinlbl.text = "0Kg"
////            cell.checkinBaggagelbl.text = "0Kg"
////        } else {
////            cell.checkinBaggagelbl.text = convertToDesiredFormat(data.weight_Allowance ?? "")
////            cell.cabinlbl.text = convertToDesiredFormat(data.weight_Allowance ?? "")
////        }
////        
////        cell.separatorLabel.isHidden = true
////        if key == "circle" {
////            cell.separatorLabel.isHidden = false
////            if tableView.isLast(for: indexPath) == true {
////                cell.separatorLabel.isHidden = true
//////                    cell.topView.isHidden = true
////            }
////        }
////        
////        ccell = cell
////    }
////    return ccell
////}
////
////
////func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////    return UITableView.automaticDimension
////}
