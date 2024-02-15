//
//  TripsViewController.swift
//  Travrun
//
//  Created by Mahesh on 09/11/23.
//

import UIKit

class TripsViewController: BaseTableVC, UPComingFlightsViewModelDelegate {
    
    @IBOutlet weak var payImage: UIImageView!
    @IBOutlet weak var visaImage: UIImageView!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var flightIconImage: UIImageView!
    @IBOutlet weak var cancelledLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var upcomingLabel: UILabel!
    @IBOutlet weak var cancelledView: UIView!
    @IBOutlet weak var completedView: UIView!
    @IBOutlet weak var upcomingView: UIView!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var visaLabel: UILabel!
    @IBOutlet weak var hotleLabel: UILabel!
    @IBOutlet weak var flightLabel: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var fightButton: UIButton!
    @IBOutlet weak var fightView: UIView!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var visaButton: UIButton!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var payView: UIView!
    
    var vocherUrl = String()
    var viewmodel:UPComingFlightsViewModel?
    var mybookings : UPComingFlightsModel?
    var resultData = [Res_data]()
    var flightdata = [Flight_data]()
    var tablerow = [TableRow]()
    var app_reference = String()
    var booking_source = String()
    var booking_status = String()
    var buttonTapKey = String()
    var tabtapkey = String()
    var payload = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewmodel = UPComingFlightsViewModel(self)
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell", "EmptyTVCell"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        tabtapkey = "flight"
        callAPI()
    }
    
    
    func setUpUI() {
//        fightView.backgroundColor = .AppGreenColor
        bannerImage.image = UIImage(named: "flightBanner")
        upcomingLabel.textColor = HexColor("FFFFFF")
        visaImage.image = UIImage(named: "visaIcon")
        payImage.image = UIImage(named: "payIcon")
        hotelImage.image = UIImage(named: "hotelIcon")
        flightIconImage.image = UIImage(named: "flightIcon")
        fightView.layer.borderColor = HexColor("#D4D4D4").cgColor
        fightView.layer.borderWidth = 1
        visaView.layer.borderWidth = 1
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.layer.borderWidth = 1
        hotelView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderWidth = 1
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        fightView.layer.borderWidth = 1
        payView.layer.cornerRadius = 6
        visaView.layer.cornerRadius = 6
        fightView.layer.cornerRadius = 6
        hotelView.layer.cornerRadius = 6
        setupTVCells()
    }
    
    @IBAction func flightButtonAction(_ sender: Any) {
        fightView.backgroundColor = .AppGreenColor
        flightLabel.textColor = UIColor.white
        visaLabel.textColor = HexColor("#3C627A")
        payLabel.textColor = HexColor("#3C627A")
        hotleLabel.textColor = .AppLabelColor
        fightView.layer.borderColor = UIColor.clear.cgColor
        hotelView.layer.borderColor = UIColor.AppGreenColor.cgColor
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.backgroundColor = UIColor.white
        visaView.backgroundColor = UIColor.white
        payView.backgroundColor = UIColor.white
        bannerImage.image = UIImage(named: "flightBanner")
        flightIconImage.image = UIImage(named: "flightIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        hotelImage.image = UIImage(named: "hotelIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppGreenColor)
        visaImage.image = UIImage(named: "visaIcon")
        payImage.image = UIImage(named: "payIcon")
        tabtapkey = "flight"
        callAPI()
//        hotelImage.image = UIImage(named: "hotelIcon")
    }
    @IBAction func hotelButtonAction(_ sender: Any) {
        fightView.backgroundColor = UIColor.white
        hotelView.backgroundColor = .AppGreenColor
        visaView.backgroundColor = UIColor.white
        payView.backgroundColor = UIColor.white
        hotelView.layer.borderColor = UIColor.clear.cgColor
        fightView.layer.borderColor = UIColor.AppGreenColor.cgColor
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        flightLabel.textColor = .AppLabelColor
        visaLabel.textColor = HexColor("#3C627A")
        payLabel.textColor = HexColor("#3C627A")
        hotleLabel.textColor = HexColor("#FFFFFF")
        bannerImage.image = UIImage(named: "hotelBanner")
        hotelImage.image = UIImage(named: "hotelIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        flightIconImage.image = UIImage(named: "flightIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppGreenColor)
        visaImage.image = UIImage(named: "visaIcon")
        payImage.image = UIImage(named: "payIcon")
//        flightIconImage.image = UIImage(named: "flightIcon")
    }
    @IBAction func visaButtonAction(_ sender: Any) {
        fightView.backgroundColor = UIColor.white
        hotelView.backgroundColor = UIColor.white
        visaView.backgroundColor = .AppBtnColor
        payView.backgroundColor = UIColor.white
        visaView.layer.borderColor = UIColor.clear.cgColor
        fightView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.layer.borderColor = HexColor("#D4D4D4").cgColor
        payView.layer.borderColor = HexColor("#D4D4D4").cgColor
        flightLabel.textColor = HexColor("#3C627A")
        visaLabel.textColor = .AppLabelColor
        payLabel.textColor = HexColor("#3C627A")
        hotleLabel.textColor = HexColor("#3C627A")
        bannerImage.image = UIImage(named: "hotelBanner")
        visaImage.image = UIImage(named: "visaIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        payImage.image = UIImage(named: "payIcon")
        hotelImage.image = UIImage(named: "hotelIcon")
        flightIconImage.image = UIImage(named: "flightIcon")
    }
    @IBAction func payButtonAction(_ sender: Any) {
        fightView.backgroundColor = UIColor.white
        hotelView.backgroundColor = UIColor.white
        visaView.backgroundColor = UIColor.white
        payView.backgroundColor = .AppBtnColor
        payView.layer.borderColor = UIColor.clear.cgColor
        fightView.layer.borderColor = HexColor("#D4D4D4").cgColor
        hotelView.layer.borderColor = HexColor("#D4D4D4").cgColor
        visaView.layer.borderColor = HexColor("#D4D4D4").cgColor
        flightLabel.textColor = HexColor("#3C627A")
        visaLabel.textColor = HexColor("#3C627A")
        payLabel.textColor = HexColor("#FFFFFF")
        hotleLabel.textColor = HexColor("#3C627A")
        payImage.image = UIImage(named: "payIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        visaImage.image = UIImage(named: "visaIcon")
        hotelImage.image = UIImage(named: "hotelIcon")
        flightIconImage.image = UIImage(named: "flightIcon")
    }
    
    @IBAction func upComingButtonAction(_ sender: Any) {
        buttonTapKey = "upcoming"
        upcomingLabel.textColor = .AppLabelColor
        completedLabel.textColor = HexColor("#000000")
        cancelledLabel.textColor = HexColor("#000000")
        cancelledView.backgroundColor = UIColor.clear
        upcomingView.backgroundColor = .AppYellowColor
        completedView.backgroundColor = UIColor.clear
        callAPI()
      
    }
    @IBAction func completedButtonAction(_ sender: Any) {
        buttonTapKey = "completed"
        upcomingLabel.textColor = HexColor("000000")
        completedLabel.textColor = .AppLabelColor
        cancelledLabel.textColor = HexColor("#000000")
        cancelledView.backgroundColor = UIColor.clear
        completedView.backgroundColor = .AppYellowColor
        upcomingView.backgroundColor = UIColor.clear
        callAPI()
    }
    @IBAction func cancelledButtonAction(_ sender: Any) {
        buttonTapKey = "cancelled"
        cancelledLabel.textColor = .AppLabelColor
        completedLabel.textColor = HexColor("#000000")
        upcomingLabel.textColor = HexColor("#000000")
        upcomingView.backgroundColor = UIColor.clear
        cancelledView.backgroundColor = .AppYellowColor
        completedView.backgroundColor = UIColor.clear
        callAPI()
    }
    
    func setupTVCells() {
        tablerow.removeAll()
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        
        resultData.forEach { i in
            vocherUrl = i.uRL ?? ""
        }
        
        
        flightdata.forEach { j in
            j.summary?.forEach({ i in
                tablerow.append(TableRow(title:vocherUrl,
                                         fromTime:i.origin?.time,
                                         toTime: i.destination?.time,
                                         fromCity:"\(i.origin?.city ?? "")(\(i.origin?.loc ?? "")",
                                         fromDate: i.origin?.date,
                                         toCity: "\(i.destination?.city ?? "")(\(i.destination?.loc ?? "")",
                                         toDate: i.destination?.date,
                                         noosStops: "\(i.no_of_stops ?? 0)",
                                         airlineslogo: i.operator_image,
                                         airlinesname:i.operator_name,
                                         airlinesCode: "(\(i.operator_code ?? "")\(i.flight_number ?? ""))",
                                         price: "\(j.transaction?.currency ?? ""):\(Double(j.transaction?.fare ?? "")?.roundToDecimal(2) ?? 0.0)",
                                         travelTime: i.duration,
                                         key:buttonTapKey,
                                         cellType:.VocherFlightDetailsTVCell))
            })
        }
    
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func callAPI() {
        DispatchQueue.main.async {[self] in
            
            if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
                TableViewHelper.EmptyMessage(message: "Please Login To View Your Flight Details", tableview: commonTableView, vc: self)
                gotoLoginVC()
            }else {
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                
                callTabSelectedAPI()
            }
        }
    }
    
    func callTabSelectedAPI() {
        
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "2738"
        
        switch buttonTapKey {
        case "upcoming":
            
            if tabtapkey == "flight" {
                DispatchQueue.main.async {
                    self.callUpComingMobileBookingAPI()
                }
            }else if tabtapkey == "hotel"{
//                callHotelAPI()
            }else {
//                callVisaAPI()
            }
            
            break
            
            
        case "completed":
            if tabtapkey == "flight" {
                DispatchQueue.main.async {
                    self.callcompletedMobileBookingAPI()
                }
            }else if tabtapkey == "hotel"{
//                callHotelAPI()
            }else {
//                callVisaAPI()
            }
            
            break
            
        case "cancelled":
            if tabtapkey == "flight" {
                DispatchQueue.main.async {
                    self.callcancelledMobileBookingAPI()
                }
            }else if tabtapkey == "hotel"{
//                callHotelAPI()
            }else {
//                callVisaAPI()
            }
            
            break
            
        default:
            break
        }
    }
    
    //MARK: - callUpComingMobileBookingAPI
    func callUpComingMobileBookingAPI() {
        resultData.removeAll()
        flightdata.removeAll()
        viewmodel?.CALL_UPCOMING_MOBIL_BOOKING(dictParam: payload)
    }
    
    //MARK: - callcompletedMobileBookingAPI
    func callcompletedMobileBookingAPI() {
        resultData.removeAll()
        flightdata.removeAll()
        viewmodel?.CALL_COMPLETED_MOBIL_BOOKING(dictParam: payload)
    }
    
    //MARK: - callcancelledMobileBookingAPI
    func callcancelledMobileBookingAPI() {
        resultData.removeAll()
        flightdata.removeAll()
        viewmodel?.CALL_CANCELLED_MOBIL_BOOKING(dictParam: payload)
    }
    
    func gotoLoginVC() {
        guard let vc = LoginViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        present(vc, animated: true)
    }
    
    
    func upcomingFlightsDetails(response: UPComingFlightsModel) {
        tablerow.removeAll()
        
        if response.flight_data?.count == 0 || response.status == false{
            TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            mybookings = response
            resultData = response.res_data ?? []
            flightdata = mybookings?.flight_data ?? []
            DispatchQueue.main.async {[self] in
                setupTVCells()
            }
        }
    }
    
    func cancelledFlightsDetails(response: UPComingFlightsModel) {
        if response.flight_data?.count == 0 {
            TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            resultData = response.res_data ?? []
            flightdata = mybookings?.flight_data ?? []
            mybookings = response
            DispatchQueue.main.async {[self] in
                setupTVCells()
            }
        }
        
    }
    
    func completedFlightsDetails(response: UPComingFlightsModel) {
        tablerow.removeAll()
       
        if response.flight_data?.count == 0 {
            
            TableViewHelper.EmptyMessage(message: "No Data Avaliable", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            mybookings = response
            resultData = response.res_data ?? []
            flightdata = mybookings?.flight_data ?? []
            resultData.forEach { i in
                booking_status = i.booking_status ?? ""
                booking_source = i.booking_source ?? ""
                app_reference = i.app_reference ?? ""
            }
            
            DispatchQueue.main.async {[self] in
                setupTVCells()
            }
        }
        
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
}

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
