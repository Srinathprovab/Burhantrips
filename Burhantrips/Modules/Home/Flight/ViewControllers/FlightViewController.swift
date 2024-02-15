//
//  FlightViewController.swift
//  Travrun
//
//  Created by MA1882 on 17/11/23.
//

import UIKit

class FlightViewController: BaseTableVC {
    

    @IBOutlet weak var holderVIew: UIView!
    @IBOutlet weak var gobackLabel: UILabel!
    @IBOutlet weak var roundTripLabel: UILabel!
    @IBOutlet weak var multicityLabel: UILabel!
    @IBOutlet weak var onewayBabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ButttonBgView: UIView!
    @IBOutlet weak var multicityView: UIView!
    @IBOutlet weak var roundTripView: UIView!
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var flightView: UIView!
    
    var isAdvanceSearch = true
    var cellIndex = Int()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var payload2 = [String:Any]()
    var viewModel : FlightListViewModel?
    var FlightListArray = [FlightSearchModel]()
    var tablerow = [TableRow]()
    var c1 = String()
    var c2 = String()
    var checkBoxArray = ["Return journey from another location"," Direct flights only"]
    var checkBool = true
    var selectArray = [String]()
    var selectArray1 = [String]()
    var moreoptionBool = true
    var calDepDate: String!
    var calRetDate: String!
    var fromdataArray = [[String:Any]]()
    var isfromVc = String()
    var comingFrom = String()
    
    static var newInstance: FlightViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightViewController
        return vc
    }
    
    var tableRow = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTv()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        //  frontView.isHidden = true
        addObserver()
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("calreloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: NSNotification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fromSelectCityVC), name: NSNotification.Name("fromSelectCityVC"), object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(topcity(notification:)), name: Notification.Name("topcity"), object: nil)
        
        setupIntialUI()
            
    }
    
    func setupIntialUI(){
        
        if keyStr == "select"  {
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    setupOneWay()
                }else if journeyType == "circle"{
                    setupRoundTrip()
                }else {
//                    setupMulticity()
                }
            }
        } else {
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    setupOneWay()
                }else if journeyType == "circle"{
                    setupRoundTrip()
                }else {
//                    setupMulticity()
                }
            }
        }
    }
    
    
    func registerTv() {
        self.commonTableView.registerTVCells(["OneWayTableViewCell","FlightSearchButtonTableViewCell","EmptyTVCell"])
    }
    
    func setUpView() {
        bannerImage.layer.cornerRadius = 40
        bannerImage.layer.maskedCorners = [.layerMinXMaxYCorner]
        bannerImage.clipsToBounds = true
        holderVIew.layer.cornerRadius = 12
        onewayBabel.textColor = HexColor("#000000")
        ButttonBgView.layer.cornerRadius = 6
        flightView.layer.cornerRadius = flightView.layer.frame.width / 2
        onewayView.layer.borderWidth = 1
        roundTripView.layer.borderWidth = 1
        multicityView.layer.borderWidth = 1
        multicityView.layer.borderColor = UIColor.AppBorderColor.cgColor
        roundTripView.layer.borderColor = UIColor.AppBorderColor.cgColor
        onewayView.layer.borderColor = UIColor.AppBorderColor.cgColor
    
        roundTripView.layer.cornerRadius = 15
        multicityView.layer.cornerRadius = 15
        onewayView.layer.cornerRadius = 15
        
        setUpTableView()
    }
    
    func setUpTableView() {
        tableRow.removeAll()
        tableRow.append(TableRow(key: "oneWay",isEditable: viewModel?.isCehckIn, cellType: .OneWayTableViewCell))
        tableRow.append(TableRow(cellType: .FlightSearchButtonTableViewCell))
        tableRow.append(TableRow(height: 26, bgColor: HexColor("#FFFFFF"), cellType: .EmptyTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    func setUpRoundTripTableView() {
        tableRow.removeAll()
        tableRow.append(TableRow(key: "roundTrip",isEditable: viewModel?.isCehckIn,cellType: .OneWayTableViewCell))
        tableRow.append(TableRow(cellType: .FlightSearchButtonTableViewCell))
        tableRow.append(TableRow(height: 26, bgColor: HexColor("#FFFFFF"), cellType: .EmptyTVCell))
        
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    func setupRoundTrip(){
        defaults.set("circle", forKey:  UserDefaultsKeys.journeyType)
        roundTripView.backgroundColor = .AppYellowColor
        multicityView.backgroundColor = UIColor.clear
        onewayView.backgroundColor = UIColor.clear
        multicityLabel.textColor = HexColor("#000000")
        roundTripLabel.textColor = HexColor("#000000")
        onewayBabel.textColor = HexColor("#000000")
        setUpRoundTripTableView()
    }
    
    func setupOneWay() {
        defaults.set("oneway", forKey:  UserDefaultsKeys.journeyType)
        roundTripView.backgroundColor = UIColor.clear
        multicityView.backgroundColor = UIColor.clear
        onewayView.backgroundColor = .AppYellowColor
        multicityLabel.textColor = HexColor("#000000")
        roundTripLabel.textColor = HexColor("#000000")
        onewayBabel.textColor = HexColor("#000000")
        setUpTableView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        if isfromVc == "HomeViewController" {
                   dismiss(animated: true)
               } else {
                   guard let vc = DashBoardTabBarViewController.newInstance.self else {return}
                   vc.modalPresentationStyle = .fullScreen
                   vc.selectedIndex = 0
                   self.present(vc, animated: false)
               }
    }
    
    @IBAction func oneWayButtonAction(_ sender: Any) {
        setupOneWay()
    }
    
    @IBAction func roundTripButtonAction(_ sender: Any) {
        setupRoundTrip()
    }
    
    @IBAction func multiCityButtonAction(_ sender: Any) {
        multicityLabel.textColor = HexColor("#000000")
        roundTripLabel.textColor = HexColor("#000000")
        onewayBabel.textColor = HexColor("#000000")
        roundTripView.backgroundColor = UIColor.clear
        multicityView.backgroundColor = .AppYellowColor
        onewayView.backgroundColor = UIColor.clear
//        bannerImage.image = UIImage(named: "multiBanner")
        showToast(message: "multiCity is not available yet. Stay tuned!")
    }
    
    
    override func didTapOnaddFromCityButton(cell: OneWayTableViewCell) {
        gotoSelectCityVC(str: "From", tokey: "Tooo")
    }
    
    override func didTapOnaddToCityButton(cell: OneWayTableViewCell) {
        gotoSelectCityVC(str: "To", tokey: "frommm")
    }
    
    override func didTapOnaddEconomyButton(cell: OneWayTableViewCell) {
        gotoAddTravelerVC()
    }
    
    func gotoAddTravelerVC() {
        guard let vc = TravellerEconomyVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func gotoSelectCityVC(str:String, tokey:String) {
        print(defaults.string(forKey: UserDefaultsKeys.journeyType) ?? "oneway")
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = str
        vc.keyStr = "flight"
        vc.tokey = tokey
        self.present(vc, animated: true)
    }
    
    override func didTapOnReturnToOnewayBtnAction(cell: OneWayTableViewCell) {
        print("didTapOnReturnToOnewayBtnAction")
        setupOneWay()
    }
    
    override func didTapOnAddReturnFlight(cell: OneWayTableViewCell) {
        setupRoundTrip()
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date")
    }
    
    override func didTapOnDepartureBtnAction(cell: OneWayTableViewCell) {
        gotoCalenderVC(key: "dep", titleStr: "Departure Date")
    }
    
    override func didTapOnReturnBtnAction(cell: OneWayTableViewCell) {
        gotoCalenderVC(key: "ret", titleStr: "Ruturn Date")
    }
    
    override func didTapOnAdvanedSearchOptions(cell: OneWayTableViewCell) {
        self.isAdvanceSearch.toggle()
        if isAdvanceSearch {
            cell.advancedSearchLabel.text = "Advanced search options"
            cell.advancedSearchLabel.textColor = HexColor("#191919")
            cell.advancedUnderlineLabel.backgroundColor = HexColor("#191919")
            cell.bottomView.isHidden = true
            commonTableView.reloadData()
        } else {
            cell.bottomView.isHidden = false
            cell.advancedSearchLabel.textColor = HexColor("#EE1935")
            cell.advancedSearchLabel.text = "-Advanced search options"
            cell.advancedUnderlineLabel.backgroundColor = HexColor("#EE1935")
            cell.isAdvanceSearh = false
            commonTableView.reloadData()
        }
    }
    
    override func didTapOnflightSearchBtnAction(cell: FlightSearchButtonTableViewCell) {
        print("didTapOnflightSearchBtnAction")
        payload.removeAll()
        loderBool = true
    
        let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType)
        

            if journeyType == "oneway" {
                payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
                payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
                payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
                payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
                payload["sector_type"] = "international"
                payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
                payload["return"] = ""
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["psscarrier"] = ""
                payload["search_flight"] = "Search"
                payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
                payload["search_source"] = "mobile"
                payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
                payload["direct_flight"] = ""
//                if viewModel?.isCehckIn == true {
//                    
//                }
//                
//                gotoSearchFlightResultVC(payload33: payload)
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil{
                    showToast(message: "Please Select Departure Date")
                }
                else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == "Add Details" {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.selectClass) == "Add Details" {
                    showToast(message: "Add Class")
                }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(payload33: payload)
                }
                
            } else {
                
                payload["v_class_round"] = defaults.string(forKey:UserDefaultsKeys.rselectClass)
                payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
                payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
                payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
                payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
                payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
                payload["sector_type"] = "international"
                payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
                payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
                payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
                payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
                payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
                payload["return"] = defaults.string(forKey:UserDefaultsKeys.rcalRetDate)
                payload["out_jrn"] = "All Times"
                payload["ret_jrn"] = "All Times"
                payload["carrier"] = ""
                payload["psscarrier"] = "ALL"
                payload["search_flight"] = "Search"
                payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
                payload["search_source"] = "mobile"
                payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
                payload["direct_flight"] = "on"
//                if viewModel?.isCehckIn == true {
//                    payload["direct_flight"] = "on"
//                }
                
//                gotoSearchFlightResultVC(payload33: payload)
                
                if defaults.string(forKey:UserDefaultsKeys.fromCity) == "" || defaults.string(forKey:UserDefaultsKeys.fromCity) == nil{
                    showToast(message: "Please Select From City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "" || defaults.string(forKey:UserDefaultsKeys.toCity) == nil{
                    showToast(message: "Please Select To City")
                }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
                    showToast(message: "Please Select Different Citys")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == nil{
                    showToast(message: "Please Select Departure Date")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == "+ Add Departure Date" || defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == nil{
                    showToast(message: "Please Select Return Date")
                }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == defaults.string(forKey:UserDefaultsKeys.rcalRetDate) {
                    showToast(message: "Please Select Different Dates")
                }
                else if defaults.string(forKey:UserDefaultsKeys.rtravellerDetails) == nil {
                    showToast(message: "Add Traveller")
                }else if defaults.string(forKey:UserDefaultsKeys.rselectClass) == nil {
                    showToast(message: "Add Class")
                }else if defaults.string(forKey:UserDefaultsKeys.fromCity) == defaults.string(forKey:UserDefaultsKeys.toCity) {
                    showToast(message: "Please Select Different Citys")
                }else if checkDepartureAndReturnDates(payload, p1: "depature", p2: "return") == false {
                    showToast(message: "Invalid Date")
                }else{
                    gotoSearchFlightResultVC(payload33: payload)
                }
            }
        }
        
    }

extension FlightViewController {
    func gotoSearchFlightResultVC(payload33:[String:Any]) {
        guard let vc = SearchResultPageViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        defaults.set(false, forKey: "flightfilteronce")
        vc.isFromVc = "searchvc"
        callapibool = true
        vc.payload = payload33
        self.present(vc, animated: true)
    }
    
    func gotoCalenderVC(key:String,titleStr:String) {
        dateSelectKey = key
        guard let vc = Calvc.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = titleStr
        callapibool = true
        self.present(vc, animated: false)
    }
}


extension FlightViewController {
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func reloadTV() {
        commonTableView.reloadData()
    }
    
    @objc func reload(notification: NSNotification){
        commonTableView.reloadData()
    }
    
    @objc func fromSelectCityVC() {
        keyStr = "select"
    }
    
    
}

extension FlightViewController {
    
    //MARK: - topcity Search
    @objc func topcity(notification: Notification) {
        payload.removeAll()
//        self.tabBarController?.tabBar.isHidden = true
        loderBool = true
        defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
        if let userinfo = notification.userInfo {
            
            payload["trip_type"] = (userinfo["trip_type"] as? String) ?? ""
            payload["adult"] = "1"
            payload["child"] = "0"
            payload["infant"] = "0"
            payload["v_class"] = (userinfo["airline_class"] as? String) ?? ""
            payload["sector_type"] = "international"
            payload["from"] = (userinfo["fromFlight"] as? String) ?? ""
            payload["from_loc_id"] = (userinfo["from_city"] as? String) ?? ""
            payload["to"] = (userinfo["toFlight"] as? String) ?? ""
            payload["to_loc_id"] = (userinfo["to_city"] as? String) ?? ""
            payload["depature"] = userinfo["travel_date"] as? String ?? ""
            payload["return"] = userinfo["return_date"] as? String ?? ""
            payload["out_jrn"] = "All Times"
            payload["ret_jrn"] = "All Times"
            payload["carrier"] = ""
            payload["psscarrier"] = "ALL"
            payload["search_flight"] = "Search"
            payload["search_source"] = "mobile"
            payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
            payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
            
            defaults.set((userinfo["trip_type"] as? String) ?? "", forKey: UserDefaultsKeys.journeyType)
            defaults.set((userinfo["from_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.fromcityname)
            defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.tocityname)
            defaults.set((userinfo["from_city_loc"] as? String) ?? "" , forKey: UserDefaultsKeys.fromairport)
            defaults.set((userinfo["to_city_name"] as? String) ?? "" , forKey: UserDefaultsKeys.toairport)
            defaults.set((userinfo["fromFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.fromCity)
            defaults.set((userinfo["toFlight"] as? String) ?? "" , forKey: UserDefaultsKeys.toCity)
            
            
            if (userinfo["trip_type"] as? String) == "oneway" {
                defaults.set((userinfo["travel_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calDepDate)
                defaults.set((userinfo["return_date"] as? String) ?? "" , forKey: UserDefaultsKeys.calRetDate)
            }else {
                defaults.set((userinfo["travel_date"] as? String) ?? "" , forKey: UserDefaultsKeys.rcalDepDate)
                defaults.set((userinfo["return_date"] as? String) ?? "" , forKey: UserDefaultsKeys.rcalRetDate)
            }
            
            gotoSearchFlightResultVC(payload33: payload)
        }
        
    }
}

extension FlightViewController {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload(notification:)), name: Notification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(topcity(notification:)), name: Notification.Name("topcity"), object: nil)
        
      
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            
            defaults.set("+965", forKey: UserDefaultsKeys.mobilecountrycode)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                self.gotoPrivacyScreen()
//            }
            defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
            defaults.set(0, forKey: UserDefaultsKeys.DashboardTapSelectedCellIndex)
            defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
            defaults.set(0, forKey: UserDefaultsKeys.journeyTypeSelectedIndex)
            defaults.set("KWD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("EN", forKey: UserDefaultsKeys.APILanguageType)
//            langLabel.text = "KWD"
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.infantsCount)
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") Adult | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") Child | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infant | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            defaults.set("Economy", forKey: UserDefaultsKeys.rselectClass)
            defaults.set("1", forKey: UserDefaultsKeys.radultCount)
            defaults.set("0", forKey: UserDefaultsKeys.rchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.rinfantsCount)
            let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") Adult | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "") Infant |\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
            defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.rtravellerDetails)
            
            
//            defaults.set("Economy", forKey: UserDefaultsKeys.mselectClass)
//            defaults.set("1", forKey: UserDefaultsKeys.madultCount)
//            defaults.set("0", forKey: UserDefaultsKeys.mchildCount)
//            defaults.set("0", forKey: UserDefaultsKeys.minfantsCount)
//            let totaltraverlers3 = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") Adult | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "") Infants |\(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
//            defaults.set(totaltraverlers3, forKey: UserDefaultsKeys.mtravellerDetails)
            
            
            
//            //Hotel default Values
//            defaults.set("1", forKey: UserDefaultsKeys.roomcount)
//            defaults.set("2", forKey: UserDefaultsKeys.hoteladultscount)
//            defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
//            defaults.set("\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "") Child", forKey: UserDefaultsKeys.selectPersons)
            
            
//            
//            //Insurence default Values
//            defaults.set("1", forKey: UserDefaultsKeys.iadultCount)
//            defaults.set("0", forKey: UserDefaultsKeys.ichildCount)
//            defaults.set("0", forKey: UserDefaultsKeys.iinfantsCount)
//            let totaltraverlers6 = "\(defaults.string(forKey: UserDefaultsKeys.iadultCount) ?? "1") Adult | \(defaults.string(forKey: UserDefaultsKeys.ichildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "") Infants "
//            defaults.set(totaltraverlers6, forKey: UserDefaultsKeys.itravellerDetails)
//            
//            defaults.set("1", forKey: UserDefaultsKeys.iradultCount)
//            defaults.set("0", forKey: UserDefaultsKeys.irchildCount)
//            defaults.set("0", forKey: UserDefaultsKeys.irinfantsCount)
//            let totaltraverlers7 = "\(defaults.string(forKey: UserDefaultsKeys.iradultCount) ?? "1") Adult | \(defaults.string(forKey: UserDefaultsKeys.irchildCount) ?? "") Child | \(defaults.string(forKey: UserDefaultsKeys.irinfantsCount) ?? "") Infants"
//            defaults.set(totaltraverlers7, forKey: UserDefaultsKeys.irtravellerDetails)
//            
//            
//            
//            //Fasttrack default Values
//            defaults.set("1", forKey: UserDefaultsKeys.fradultCount)
//            defaults.set("0", forKey: UserDefaultsKeys.frchildCount)
//            let totaltraverlers8 = "\(defaults.string(forKey: UserDefaultsKeys.fradultCount) ?? "1") Adult | \(defaults.string(forKey: UserDefaultsKeys.frchildCount) ?? "") Child"
//            defaults.set(totaltraverlers8, forKey: UserDefaultsKeys.frtravellerDetails)
//            
            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
            
        }
        
    }
    
    
}
