//
//  BookingDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 01/12/23.
//

import UIKit

class BookingDetailsViewController: BaseTableVC, RegisterViewModelProtocal, ProfileDetailsViewModelDelegate, FDViewModelDelegate, MBViewModelDelegate, AllCountryCodeListViewModelDelegate {
    func mobileprocesspassengerDetails(response: MBPModel) {
        print("mobileprocesspassengerDetails")
    }
    
    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
        print("mobileprepaymentconfirmationDetails")
    }
    
    func mobilesendtopaymentDetails(response: MobilePrePaymentModel) {
        print("mobilesendtopaymentDetails")
    }
    

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var backButtonView: UIView!
    var tablerow = [TableRow]()
    var viewmodel1:ProfileDetailsViewModel?
    var viewmodel2 : FDViewModel?
    static var newInstance: BookingDetailsViewController? {
        let storyboard = UIStoryboard(name: Storyboard.BookingDetails.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingDetailsViewController
        return vc
    }
    
    var countryCode = String()
    var nationalityCode = String()
    
    var showMoreBool = true
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var checkBool = false
    var accesskeytp = String()
    var accesskey = String()
    var bookingsource = String()
    var tmpFlightPreBookingId = String()
    var activepaymentoptions = String()
    var totalPrice = Double()
    var appreference = String()
    var totalPrice1 = String()
    var isVcFrom = String()
    let seconds = 0.1
    var isOpen = true
    var billingCountryName = String()
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    var mbRefundable = String()
    var timer: Timer?
    var totalTime = 1
    
    var positionsCount = 0
    var passengertypeArray = [String]()
    var searchTextArray = [String]()
    var totalAmountforBooking = String()
    var grand_total_Price = String()
    
    var regViewModel: RegisterViewModel?
    var mbviewmodel: MBViewModel?
    var viewmodel:AllCountryCodeListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mbviewmodel = MBViewModel(self)
        viewmodel1 = ProfileDetailsViewModel(self)
        regViewModel = RegisterViewModel(self)
        viewmodel2 = FDViewModel(self)
        viewmodel = AllCountryCodeListViewModel(self)
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell",
                                         "EmptyTVCell", "RegisterSelectionLoginTableViewCell", "GuestRegisterTableViewCell", "RegisterNowTableViewCell", "LoginDetailsTableViewCell", "AddAdultTableViewCell", "FareSummaryTableViewCell", "AcceptTermsAndConditionTVCell", "HeaderTableViewCell", "AddressTableViewCell", "BookFlightDetailsTVCell"])
        setupTVCells()
        callProfileDetailsAPI()
        callGetFlightDetailsAPI()
        callMobilePreProcessingBookingAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
//        addObserver()
        searchTextArray.removeAll()
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                
            } else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rinfantsCount) ?? "0") ?? 0
            } else {
                //                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                //                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                //                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.minfantsCount) ?? "0") ?? 0
            }
            
           
        }
        
        if callapibool == true {
//            holderView.isHidden = true
//            callAllAPIS()
        }
    }
    
    func setupTVCells() {
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:self.mbRefundable,
                                 subTitle: "",
                                 moreData: mbSummery,
                                 cellType:.BookFlightDetailsTVCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            if mbviewmodel?.section == .guestLogin {
                tablerow.append(TableRow(cellType: .GuestRegisterTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            } else if mbviewmodel?.section == .register {
                tablerow.append(TableRow(cellType: .LoginDetailsTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            } else if mbviewmodel?.section == .login {
                tablerow.append(TableRow(key: "register",cellType: .RegisterNowTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            }
        } else {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        
        for i in 1...2 {
            positionsCount += 1
            passengertypeArray.append("Adult")
            let travellerCell = TableRow(title: "Adult \(i)", key: "adult",characterLimit: positionsCount, isEditable: mbviewmodel?.isDropOpen, cellType: .AddAdultTableViewCell)
            searchTextArray.append("Adult \(i)")
            tablerow.append(travellerCell)
        }
        //        tablerow.append(TableRow(cellType: .AddAdultTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(title: "AddAdult", cellType: .HeaderTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .AddressTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .FareSummaryTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(height: 100, bgColor: .white, cellType: .AcceptTermsAndConditionTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    //MARK: - didTapOnTCBtn TravelInsuranceTVCell =====
    override func didTapOnviewFlifgtDetailsBtn(cell: BookFlightDetailsTVCell) {
        guard let vc = FlightDetailsViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func didTapOnguestButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioUnselect")
        cell.loginRadioImage.image = UIImage(named: "radioUnselect")
        cell.guestRadioImage.image = UIImage(named: "radioSelect")
        mbviewmodel?.section = .guestLogin
        setupTVCells()
        
    }
    override func registerButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioSelect")
        cell.loginRadioImage.image = UIImage(named: "radioUnselect")
        cell.guestRadioImage.image = UIImage(named: "radioUnselect")
        mbviewmodel?.section = .register
        setupTVCells()
    }
    override func loginButton(cell: RegisterSelectionLoginTableViewCell) {
        cell.registerRadioImage.image = UIImage(named: "radioUnselect")
        cell.loginRadioImage.image = UIImage(named: "radioSelect")
        cell.guestRadioImage.image = UIImage(named: "radioUnselect")
        mbviewmodel?.section = .login
        setupTVCells()
    }
    
    override func loginNowButtonAction(cell: RegisterNowTableViewCell, email: String, pass: String) {
        print("loginNowButtonAction")
        callLoginAPI(email: email, pass: pass)
        callProfileDetailsAPI()
    }
    
    override func RegisterNowButtonAction(cell: LoginDetailsTableViewCell, email: String, pass: String, phone: String) {
        callRegisterAPI(email: email, pass: pass, mobile: phone)
        callProfileDetailsAPI()
    }
    
    override func didTaponSwitchButton(cell: AddAdultTableViewCell) {
        cell.frequentView.isHidden = false
    }
    
    override func travListButtonAction() {}
    
    override func didTaponPassangerButton(cell: AddAdultTableViewCell) {
        if cell.expandViewBool == true {
            cell.expandView()
            cell.expandViewBool = false
        } else {
            cell.collapsView()
            cell.expandViewBool = true
        }
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
}


// ligin Api Calls
extension BookingDetailsViewController {
    func callLoginAPI(email: String, pass: String) {
        payload["username"] = email
        payload["password"] = pass
        regViewModel?.CallLoginAPI(dictParam: payload)
        callProfileDetailsAPI()
    }
    
    func callRegisterAPI(email: String, pass: String, mobile: String) {
        payload["email"] = email
        payload["password"] = pass
        payload["phone"] = mobile
        regViewModel?.CallRegisterAPI(dictParam: payload)
        callProfileDetailsAPI()
    }
}

extension BookingDetailsViewController {
    func RegisterDetails(response: RegisterModel) {
        print(response)
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            showToast(message: "Register Sucess")
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.data?.user_id, forKey: UserDefaultsKeys.userid)
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                if isVcFrom == "BookingDetailsViewController" {
                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                    self.dismiss(animated: true)
                }else {
                    //                    commonTableView.reloadData()
                    setupTVCells()
                }
            }
        }
    }
    
    
    func loginDetails(response: LoginModel) {
        print(response)
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                
                if isVcFrom == "BookingDetailsViewController" || isVcFrom == "SideMenuViewController"{
                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                    self.dismiss(animated: true)
                }else {
                    //                        tablerow.removeAll()
                    setupTVCells()
                }
            }
        }
    }
}

extension BookingDetailsViewController {
    //MARK: - call Profile Details API
    func callProfileDetailsAPI() {
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        viewmodel1?.CallGetProileDetails_API(dictParam: payload)
    }
    
    
    func getProfileDetails(response: ProfileDetailsModel) {
        print(" =====   getProfileDetails ====== \(response)")
        pdetails = response.data
        defaults.set(response.data?.email, forKey: UserDefaultsKeys.useremail)
        defaults.set(response.data?.phone, forKey: UserDefaultsKeys.usermobile)
    }
    
    func updateProfileDetails(response: ProfileDetailsModel) {}
}
extension BookingDetailsViewController {
    func callGetFlightDetailsAPI() {
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResultindex"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey) ?? "0"
        viewmodel2?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
    }
    
    func flightDetails(response: FDModel) {
        holderView.isHidden = false
        fd = response.flightDetails ?? []
        
        jd = response.journeySummary ?? []
        fareRulehtml = response.fareRulehtml ?? []
        totalprice = "\(response.priceDetails?.api_currency ?? "") : \(response.priceDetails?.grand_total ?? "")"
        grandTotal = totalprice
        farerulerefkey = response.fare_rule_ref_key ?? ""
        farerulesrefcontent = response.farerulesref_content ?? ""
        fareCurrencyType = String(response.priceDetails?.api_currency ?? "")
        Adults_Base_Price = String(response.priceDetails?.adultsBasePrice ?? "0")
        Adults_Tax_Price = String(response.priceDetails?.adultsTaxPrice ?? "0")
        Childs_Base_Price = String(response.priceDetails?.childBasePrice ?? "0")
        Childs_Tax_Price = String(response.priceDetails?.childTaxPrice ?? "0")
        Infants_Base_Price = String(response.priceDetails?.infantBasePrice ?? "0")
        Infants_Tax_Price = String(response.priceDetails?.infantTaxPrice ?? "0")
        AdultsTotalPrice = String(response.priceDetails?.adultsTotalPrice ?? "0")
        ChildTotalPrice = String(response.priceDetails?.childTotalPrice ?? "0")
        InfantTotalPrice = String(response.priceDetails?.infantTotalPrice ?? "0")
        sub_total_adult = String(response.priceDetails?.sub_total_adult ?? "0")
        sub_total_child = String(response.priceDetails?.sub_total_child ?? "0")
        sub_total_infant = String(response.priceDetails?.sub_total_infant ?? "0")
    }
    
}

extension BookingDetailsViewController {
    
    
    //MARK: -call Mobile Pre Processing Booking API
    func callMobilePreProcessingBookingAPI() {
        
        payload.removeAll()
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? 0
        payload["traceId"] = defaults.string(forKey: UserDefaultsKeys.traceId) ?? 0
        mbviewmodel?.CALLPREPROCESSINGBOOKINGAPI(dictParam: payload)
    }
    
    
    func mobilepreprocessbookingDetails(response: MBModel) {
        holderView.isHidden = false
        accesskey = response.pre_booking_params?.access_key ?? ""
        accesskeytp = response.access_key_tp ?? ""
        bookingsource = response.booking_source ?? ""
        tmpFlightPreBookingId = response.pre_booking_params?.transaction_id ?? ""
        activepaymentoptions = response.active_payment_options?[0] ?? ""
        totalPrice = Double(String(format: "%.2f", response.total_price ?? "")) ?? 0.0
        appreference = response.pre_booking_params?.transaction_id ?? ""
        frequent_flyersArray = response.frequent_flyers ?? []
        
        DispatchQueue.main.async {
            mbSummery = response.flight_data?[0].flightDetails?.summery ?? []
        }
        
        mbRefundable = defaults.string(forKey: UserDefaultsKeys.selectedFareType) ?? "Non Refundable"
        let i = response.pre_booking_params?.priceDetails
        Adults_Base_Price = String(i?.adultsBasePrice ?? "0.0")
        Adults_Tax_Price = String(i?.adultsTaxPrice ?? "0.0")
        Childs_Base_Price = String(i?.childBasePrice ?? "0.0")
        Childs_Tax_Price = String(i?.childTaxPrice ?? "0.0")
        Infants_Base_Price = String(i?.infantBasePrice ?? "0.0")
        Infants_Tax_Price = String(i?.infantTaxPrice ?? "0.0")
        AdultsTotalPrice = i?.adultsTotalPrice ?? "0"
        ChildTotalPrice = i?.childTotalPrice ?? "0"
        InfantTotalPrice = i?.infantTotalPrice ?? "0"
        sub_total_adult = i?.sub_total_adult ?? "0"
        sub_total_child = i?.sub_total_child ?? "0"
        sub_total_infant = i?.sub_total_infant ?? "0"
        
        grand_total_Price = i?.grand_total ?? ""
        totalAmountforBooking = i?.grand_total ?? ""
        TimerManager.shared.stopTimer()
        TimerManager.shared.startTimer(time: 900)
        
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.seconds) {
            self.callGetCointryListAPI()
        }
    }
    
    func mobilePreBookingModelDetails(response: MobilePreBookingModel) {
        //        BASE_URL = ""
        //        payload["search_id"] = response.data?.search_id
        //        payload["app_reference"] = response.data?.app_reference
        //        payload["promocode_val"] = response.data?.promocode_val
        //        payload["selectedCurrency"] = defaults.string(forKey: UserDefaultsKeys.selectedCurrency)
        //
        //
        //
        //        if response.status == false {
        //            showToast(message: response.message ?? "")
        //        }else {
        //            mbviewmodel?.Call_mobile_pre_payment_confirmation_API(dictParam: payload, url: "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/flight/mobile_pre_payment_confirmation")
        //        }
    }
    
    //    func mobileprepaymentconfirmationDetails(response: MobilePrePaymentModel) {
    //
    //
    ////        if response.status == false {
    ////            showToast(message: response.message ?? "")
    ////        }else {
    ////            BASE_URL = ""
    ////            mbviewmodel?.Call_mobile_send_to_payment_API(dictParam: [:], url: response.url ?? "")
    ////        }
    //
    //    }
    //
}

extension BookingDetailsViewController {
    //MARK: - Call Get Cointry List API
    
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
    }
    
    func callGetCointryListAPI() {
        viewmodel?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
}


extension BookingDetailsViewController {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAfterLogin), name: NSNotification.Name("reloadAfterLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(passportexpiry), name: NSNotification.Name("passportexpiry"), object: nil)
        
    }
    
    
    @objc func passportexpiry(notify:NSNotification) {
        passportExpireDateBool = false
        showToast(message: (notify.object as? String) ?? "")
    }
    
    
    @objc func reloadTV() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
//                        callAllAPIS()
        }
    }
    
    func callAllAPIS() {
//        MBfd?.removeAll()
        TimerManager.shared.sessionStop()
        
        DispatchQueue.main.async {
            self.callMobilePreProcessingBookingAPI()
        }
        
        
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    //MARK: - reloadAfterLogin
    @objc func reloadAfterLogin() {
        callProfileDetailsAPI()
    }
    
    
    //MARK: - updateTimer
    func updateTimer() {
        let totalTime = TimerManager.shared.totalTime
        let minutes =  totalTime / 60
        let seconds = totalTime % 60
        let formattedTime = String(format: "%02d:%02d", minutes, seconds)
        
        //        setuplabels(lbl: sessonlbl, text: "Your Session Expires In : \(formattedTime)", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
    }
}
