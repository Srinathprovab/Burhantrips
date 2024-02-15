//
//  HomeViewController.swift
//  Travrun
//
//  Created by Mahesh on 09/11/23.
//

import UIKit

class HomeViewController: BaseTableVC, AllCountryCodeListViewModelDelegate, TopFlightDetailsViewModelDelegate {
    
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    @IBOutlet weak var payIcon: UIImageView!
    @IBOutlet weak var visaIcon: UIImageView!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var flightImage: UIImageView!
    @IBOutlet weak var fightButton: UIButton!
    @IBOutlet weak var fightView: UIView!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var hotelView: UIView!
    @IBOutlet weak var visaButton: UIButton!
    @IBOutlet weak var visaView: UIView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var tabSelectCV: UICollectionView!
    
    static var newInstance: HomeViewController? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HomeViewController
        return vc
    }
    
    var tabNames = ["Flight","Hotel","Visa", "Pay"]
    var tabNamesImages = ["flightIcon","hotelIcon","visaIcon", "payIcon"]
    var tableRow = [TableRow]()
    
    private var sideMenuViewController: SideMenuViewController!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    var vm: AllCountryCodeListViewModel?
    var viewmodel: TopFlightDetailsViewModel?
    var viewModel1 : FlightListViewModel?
    var profileViewmodel: ProfileDetailsViewModel?
    var payload = [String:Any]()
    
    override func viewDidLoad() {
        tabBarController?.tabBar.isHidden = false
        super.viewDidLoad()
        priceLabel.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""
        print("HomeViewController")
        setUpView()
        viewmodel = TopFlightDetailsViewModel(self)
        vm = AllCountryCodeListViewModel(self)
        callCountryListAPI()
        self.callApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        hidesBottomBarWhenPushed = false
        
        addObserver()
        if callapibool == true {
            DispatchQueue.main.async {
                self.callApi()
            }
        }
    }
    
    func callApi() {
        DispatchQueue.main.async {
            self.callTopFlightsHotelsDetailsAPI()
        }
    }
    
    func callTopFlightsHotelsDetailsAPI() {
        viewmodel?.callTopFlightsHotelsDetailsAPI(dictParam: [:])
    }
    
    func callCountryListAPI() {
        vm?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
    }
    
    //MARK: REGISTER TABEL VIEW CELLS
    
    func setUpView() {
        

        self.commonTableView.registerTVCells(["SpecialDealsTVCell","TopCityTVCell","EmptyTVCell", "holidayTableViewCell", "HeaderTableViewCell", "RecommendedHotelTVCell", "TopCityTVCell", "BestPriceTVCell"])
        priceLabel.textColor = .AppLabelColor
        priceLabel.font = UIFont.PoppinsRegular(size: 14)
        payView.layer.cornerRadius = 6
        visaView.layer.cornerRadius = 6
        fightView.layer.cornerRadius = 6
        hotelView.layer.cornerRadius = 6
        
        bannerView.layer.cornerRadius = 40
        bannerView.layer.maskedCorners = [.layerMinXMaxYCorner]
        bannerView.clipsToBounds = true
        setUpTableView()
        setupMenu()
    }
    
    
    
    func setUpTableView() {
        tableRow.removeAll()
        tableRow.append(TableRow(height: 10,cellType: .EmptyTVCell))
        tableRow.append(TableRow(cellType: .BestPriceTVCell))
        tableRow.append(TableRow(key: "top",buttonTitle: "Top Citys", height: 80, cellType: .HeaderTableViewCell))
        
        tableRow.append(TableRow(title:"Popular Destinations", key: "flights", cellType: .SpecialDealsTVCell))
        
        tableRow.append(TableRow(key: "bestHotel",buttonTitle: "Recommended Best Hotels", height: 80,cellType: .HeaderTableViewCell))
        
        if topHotelDetails.count != 0 {
            tableRow.append(TableRow(cellType: .RecommendedHotelTVCell))
        } else {
            tableRow.append(TableRow(height: 0,cellType: .EmptyTVCell))
        }
        
        tableRow.append(TableRow(key: "holiday",buttonTitle: "Trending Destinations", height: 90, cellType: .HeaderTableViewCell))
        
        if topHolidayList.count != 0 {
            tableRow.append(TableRow(cellType: .TopCityTVCell))
        } else {
            tableRow.append(TableRow(height: 0,cellType: .EmptyTVCell))
        }
        
        tableRow.append(TableRow(height: 30,cellType: .EmptyTVCell))
        
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    //MARK: - RELOAD TABLE VIEW
    @objc func reload(notification: Notification) {
        commonTableView.reloadData()
    }
    
    
    @IBAction func currencyButtonAction(_ sender: Any) {
        guard let vc = SelectLanguageViewController.newInstance.self else {return}
        priceLabel.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    @IBAction func sideMenuButtonAction(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
        self.tabBarController?.tabBar.isHidden = true
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    @IBAction func flightButtonAction(_ sender: Any) {
        guard let vc = FlightViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        keyStr = "search"
        vc.isfromVc = "dashboardvc"
        defaults.set("Flights", forKey: UserDefaultsKeys.dashboardTapSelected)
        callapibool = true
        self.present(vc, animated: true)
    }
    
    
    @IBAction func hotelButtonAction(_ sender: Any) {
                guard let vc = SearchHotelsVC.newInstance.self else {return}
                vc.modalPresentationStyle = .overCurrentContext
                defaults.set("Hotels", forKey: UserDefaultsKeys.dashboardTapSelected)
                vc.isFromvc = "HomeViewController"
                callapibool = true
                self.present(vc, animated: true)
//        showToast(message: "Hotel module is not available yet. Stay tuned!")
    }
    
}


extension HomeViewController {
    func setupMenu(){
        
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "DashBoard", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 100),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("callprofileapi"), object: nil)
            self.tabBarController?.tabBar.isHidden = true
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
            
        }
        else {
            self.tabBarController?.tabBar.isHidden = false
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
            
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    //MARK: CALL TOP FLIGHT DETAILS IMAGES API FUNCTION
    func topFlightDetailsImages(response: TopFlightDetailsModel) {
        topFlightDetails = response.topFlightDetails ?? []
        topHotelDetails = response.topHotelDetails ?? []
        deailcodelist = response.deail_code_list ?? []
        topHolidayList = response.holiday_top_destination ?? []
        DispatchQueue.main.async {[self] in
            setUpTableView()
        }
        
        DispatchQueue.main.async {[self] in
            callCountryListAPI()
        }
    }
}

extension HomeViewController: UIGestureRecognizerDelegate {
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}

extension HomeViewController {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(currencyCall), name: Notification.Name("currency"), object: nil)
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
            priceLabel.text = "KWD"
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
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
            
        }
        
    }
    
//    payload["v_class_round"] = defaults.string(forKey:UserDefaultsKeys.rselectClass)
//    payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
//    payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
//    payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
//    payload["infant"] = defaults.string(forKey:UserDefaultsKeys.infantsCount)
//    payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
//    payload["sector_type"] = "international"
//    payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
//    payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
//    payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
//    payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
//    payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
//    payload["return"] = defaults.string(forKey:UserDefaultsKeys.rcalRetDate)
//    payload["out_jrn"] = "All Times"
//    payload["ret_jrn"] = "All Times"
//    payload["carrier"] = ""
//    payload["psscarrier"] = "ALL"
//    payload["search_flight"] = "Search"
//    payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
//    payload["search_source"] = "mobile"
//    payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
//    payload["direct_flight"] = "on"
//    
    
    //MARK: - topcity Search
    @objc func topcity(notification: Notification) {
        payload.removeAll()
        self.tabBarController?.tabBar.isHidden = true
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
            payload["user_id"] = defaults.string(forKey:UserDefaultsKeys.userid) ?? "0"
            payload["currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency) ?? "KWD"
            payload["direct_flight"] = ""
            payload["search_source"] = "mobile"
            
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
            
            
            gotoSearchFlightResultVC()
        }
        
    }
    
    func gotoSearchFlightResultVC() {
        loderBool = true
        callapibool = true
        self.tabBarController?.tabBar.isHidden = false
        guard let vc = SearchResultPageViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.payload = self.payload
        self.present(vc, animated: false)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        self.tabBarController?.tabBar.isHidden = false
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @objc func currencyCall()
    {
        priceLabel.text = defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? ""
    }
    
    @objc func reloadTV() {
        //callApi()
        commonTableView.reloadData()
    }
}
