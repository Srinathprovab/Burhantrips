//
//  SideMenuViewController.swift
//  Travrun
//
//  Created by MA1882 on 15/11/23.
//

import UIKit

class SideMenuViewController: BaseTableVC, ProfileDetailsViewModelDelegate, LogoutViewModelDelegate, AboutusViewModelDelegate {
    
    static var newInstance: SideMenuViewController? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuViewController
        return vc
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var viewmodel1:ProfileDetailsViewModel?
    var logoutvm :LogoutViewModel?
    var moreDeatilsViewModel:AboutusViewModel?
    var contactusDetails:ContactUsData?
    var profilcallAPIBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel1 = ProfileDetailsViewModel(self)
        logoutvm = LogoutViewModel(self)
        moreDeatilsViewModel = AboutusViewModel(self)
        setupUI()
        setupMenuTVCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if profilcallAPIBool == true {
            DispatchQueue.main.async {
                self.callProfileDetailsAPI()
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(callprofileapi), name: Notification.Name("reloadAfterLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(callprofileapi), name: Notification.Name("callprofileapi"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    //MARK: - callprofileapi
    @objc func callprofileapi() {
        DispatchQueue.main.async {
            self.callProfileDetailsAPI()
        }
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    func setupUI() {
        commonTableView.isScrollEnabled = true
        commonTableView.registerTVCells(["MenuBGTVCell",
                                         "QuickLinkTableViewCell",
                                         "SideMenuTitleTVCell",
                                         "EmptyTVCell", "MenuTitleTVCell", "sideMenuOptionsTVCell", "AboutusTVCell", "checkOptionsTVCell"])
    }
    
    func setupMenuTVCells() {
        tablerow.removeAll()
        tablerow.append(TableRow(cellType: .MenuBGTVCell))
        tablerow.append(TableRow(title:"Bookings",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(title:"Flight",key: "menu", image: "flightIcon",cellType:.sideMenuOptionsTVCell))
        tablerow.append(TableRow(title:"Hotel",key: "menu", image: "hotelIcon",cellType:.sideMenuOptionsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Traveler Tools",key: "ourproducts", image: "",cellType:.MenuTitleTVCell))
        tablerow.append(TableRow(title:"Offers",key: "mail", image: "offers",cellType:.sideMenuOptionsTVCell))
        tablerow.append(TableRow(title:"Manage Booking",key: "menu", image: "mbooking",cellType:.sideMenuOptionsTVCell))
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Legal",key: "ourproducts", image: "",cellType: .MenuTitleTVCell))
        tablerow.append(TableRow(cellType: .AboutusTVCell))
        tablerow.append(TableRow(height:60,cellType:.EmptyTVCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            tablerow.append(TableRow(title:"Logout",key: "logout", image: "IonLogOut",cellType:.SideMenuTitleTVCell))
        }
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func aboutusDetails(response: AboutUsModel) {
        
    }
    
    func termsandcobditionDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    func privacyPolicyDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    func contactDetals(response: ContactUsModel) {
        contactusDetails = response.data
        DispatchQueue.main.async {[self] in
            gotoContactUsVC()
        }
    }
    
    //MARK: - Load URLS of T&C And Privacy Policy
    
    func gotoAboutUsVC(title:String,desc:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.titleString = title
        vc.key1 = "webviewhide"
        vc.desc = desc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    func gotoContactUsVC() {
        guard let vc = ContactUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnMenuOptionBtn
    override func didTapOnMenuOptionBtn(cell: sideMenuOptionsTVCell) {
        switch cell.titlelbl.text {
            
        case "Check My Bookings":
            //            gotoMyBookingVC()
            break
            
        case "Flight":
            gotoBookFlightsVC()
            break
            
        case "Hotel":
            //             gotoBookHotelsVC()
            showToast(message: "Hotel module is not available yet. Stay tuned!")
            break
            
        case "Holidays":
            showToast(message: "Holidays module is not available yet. Stay tuned!")
            break
            
        case "Logout":
            break
            
            
        case "Delete Account":
            //            loderBool = false
            //            payload.removeAll()
            //            payload["user_id"]  = defaults.string(forKey: UserDefaultsKeys.userid)
            //            vm?.CALL_DELETE_USER_ACCOUNT_API(dictParam: payload)
            break
            
            
        case "Info@holidayscenter.com":
            //            openMail()
            break
            
            
        default:
            break
        }
    }
    
    //MARK: - didTapOnAboutUsLink
    func gotoBookFlightsVC() {
        guard let vc = FlightViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        //        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    override func didTapOnAboutUsLink(cell: AboutusTVCell) {
        
        
    }
    override func didTapOnTermsLink(cell: AboutusTVCell) {
        payload.removeAll()
        BASE_URL = ""
        payload["id"] = "3"
        moreDeatilsViewModel?.CALL_GET_TERMSANDCONDITION_API(dictParam: payload, url: "https://provabdevelopment.com/burhan_trips/pro_new/mobile/index.php/general/cms")
        
    }
    override  func didTapOnCoockiesLink(cell: AboutusTVCell) {
        payload.removeAll()
        BASE_URL = ""
        payload["id"] = "4"
        moreDeatilsViewModel?.CALL_GET_PRIVICYPOLICY_API(dictParam: payload, url: "https://provabdevelopment.com/burhan_trips/pro_new/mobile/index.php/general/cms")
    }
    
    override  func didTapOnContactUs(cell: AboutusTVCell) {
//        payload.removeAll()
//        BASE_URL = ""
//        payload["id"] = "1"
//        moreDeatilsViewModel?.CALL_CONTACTUS_API(dictParam: payload, url: "https://provabdevelopment.com/burhan_trips/pro_new/mobile/index.php/general/contactus")
    }
    
    
    //MARK: - gotoBookHotelsVC
    func gotoBookHotelsVC() {
        guard let vc = SearchHotelsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        //        isFromVCBool = true
        present(vc, animated: true)
    }
    
    
    
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "SideMenuVC"
        present(vc, animated: true)
        
    }
    
    override func didTaponCell(cell: SideMenuTitleTVCell) {
        switch cell.menuTitlelbl.text {
        case "Flight":
            print("Flight")
            showFlightSearchVC()
            break
        case "Hotel":
            print("Hotel")
            break
        case "Visa":
            print("Visa")
            break
        case "Auto Payment":
            print("Auto Payment")
            break
        case "My Bookings":
            print("My Bookings")
            break
        case "Free Cancelation":
            print("Free Cancelation")
            break
        case "Customer Support":
            print("Customer Support")
            break
        case "Logout":
            print("logout here")
            callLogoutAPI()
            break
        default:
            break
        }
    }
    
    func showFlightSearchVC() {
        guard let vc = FlightViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func callLogoutAPI() {
        BASE_URL = BASE_URL1
        payload.removeAll()
        payload["username"] = defaults.string(forKey: UserDefaultsKeys.useremail) ?? ""
        logoutvm?.CALL_MOBILE_USER_LOGOUT_API(dictParam: payload)
    }
    
    
    func logoutSucessDetails(response: LogoutModel) {
        showToast(message: "Logged out Successfully !!")
        let seconds = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            defaults.set(false, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set("0", forKey: UserDefaultsKeys.userid)
            defaults.set("", forKey: UserDefaultsKeys.useremail)
            defaults.set("", forKey: UserDefaultsKeys.usermobile)
            defaults.set("", forKey: UserDefaultsKeys.uname)
            defaults.set("", forKey: UserDefaultsKeys.mcountrycode)
            
            // Reset Standard User Defaults
            UserDefaults.resetStandardUserDefaults()
            self.setupMenuTVCells()
        }
    }
    
    
    
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == true {
            guard let vc = EditProfileVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            vc.showKey = "profiledit"
            present(vc, animated: true)
        } else {
            guard let vc = LoginViewController.newInstance.self else {return}
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
        }
    }
    
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
        
        DispatchQueue.main.async {[self] in
            setupMenuTVCells()
        }
    }
    
    func updateProfileDetails(response: ProfileDetailsModel) {}
}

