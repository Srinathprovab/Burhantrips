//
//  FlightDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 23/11/23.
//

import UIKit

class FlightDetailsViewController: BaseTableVC, FDViewModelDelegate, FareRulesModelViewModelDelegate{
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var buttonView: BorderedView!
    @IBOutlet weak var tvTraling: NSLayoutConstraint!
    
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var middleConstraint: NSLayoutConstraint!
    @IBOutlet weak var tvLeading: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bagInfoLabel: UILabel!
    @IBOutlet weak var breakDownLabel: UILabel!
    @IBOutlet weak var farerulesLabel: UILabel!
    @IBOutlet weak var iternaryLabel: UILabel!
    @IBOutlet weak var fareRulesView: BorderedView!
    @IBOutlet weak var bagInfoView: BorderedView!
    @IBOutlet weak var breakdownView: BorderedView!
    @IBOutlet weak var iternaryView: BorderedView!
    
    var fareRulesData = [FareRulesData]()
    var newFareRules: CustomFarerules?
    
    static var newInstance: FlightDetailsViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightDetailsViewController
        return vc
    }
    
    var isVCFrom = String()
    var tablerow = [TableRow]()
    var viewmodel : FlightDetailsViewModel?
    var viewmodel1 : FDViewModel?
    var payload = [String:Any]()
    var fdetails = [FDFlightDetails]()
    var jSummary = [JourneySummary]()
    var tableRow = [TableRow]()
    var fareruleViewModel : FareRulesModelViewModel?
    var dropdownBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvLeading.constant = 0
        tvTraling.constant = 0
        registerTv()
        viewmodel1 = FDViewModel(self)
        fareruleViewModel = FareRulesModelViewModel(self)
        setUpView()
    }
    
    func registerTv() {
        self.commonTableView.registerTVCells(["FlightInfoTableViewCell", "FareBreakDownTableViewCell","totalDiscountTVCell", "FareRulesTableViewCell", "EmptyTVCell", "BaggageInfoTableViewCell", "ContactUsLabelTVCell", "HeaderTableViewCell", "ItineraryAddTVCell", "NewBaggageTVCell", "FareRulesTVCell"])
    }
    
    func setUpView() {
        if isVCFrom == "BookingDetailsVC" {
            buttonView.isHidden = true
        } else {
            buttonView.isHidden = false
        }
        currencyLabel.text = grandTotal
        dismissView.layer.cornerRadius = dismissView.layer.frame.width / 2
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topView.layer.cornerRadius = 30
        topView.clipsToBounds = true
        callGetFlightDetailsAPI()
        callFareRulesAPI()
    }
    
    
    func setUpBreakDown() {
        tvLeading.constant = 15
        tvTraling.constant = 15
        tableRow.removeAll()
        tableRow.append(TableRow(cellType: .FareBreakDownTableViewCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    func setUpFareRules() {
        tableRow.removeAll()
        tableRow.append(TableRow(key: "Cancellation Fee", moreData: newFareRules,cellType: .FareRulesTableViewCell))
        tableRow.append(TableRow(height: 20,bgColor: UIColor.clear, cellType: .EmptyTVCell))
        tableRow.append(TableRow(key: "Airline Date change",cellType: .FareRulesTableViewCell))
        tableRow.append(TableRow(height: 20,bgColor: UIColor.clear, cellType: .EmptyTVCell))
        tableRow.append(TableRow(key:"note",bgColor: UIColor.clear, cellType: .HeaderTableViewCell))
        tableRow.append(TableRow(height: 7,bgColor: UIColor.clear, cellType: .EmptyTVCell))
        tableRow.append(TableRow(key:"Lorem",text: thefareRules?.please_note,height: 85, bgColor: UIColor.clear, cellType: .HeaderTableViewCell))
       
    }
    
    func setUpBaggageInfo() {
        tvLeading.constant = 15
        tvTraling.constant = 15
        tableRow.removeAll()
        tableRow.append(TableRow(moreData: jSummary, cellType: .NewBaggageTVCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    @IBAction func breakDownButtonAction(_ sender: Any) {
        breakdownView.layer.borderColor = UIColor.clear.cgColor
        fareRulesView.layer.borderColor = HexColor("#ECECEC").cgColor
        bagInfoView.layer.borderColor = HexColor("#ECECEC").cgColor
        iternaryView.layer.borderColor = HexColor("#ECECEC").cgColor
        breakdownView.backgroundColor = HexColor("#B6BDC7")
        breakDownLabel.textColor = HexColor("#000000")
        fareRulesView.backgroundColor = HexColor("#FFFFFF")
        farerulesLabel.textColor = HexColor("#000000")
        iternaryView.backgroundColor = HexColor("#FFFFFF")
        iternaryLabel.textColor = HexColor("#000000")
        bagInfoView.backgroundColor = HexColor("#FFFFFF")
        bagInfoLabel.textColor = HexColor("#000000")
        setUpBreakDown()
    }
    
    @IBAction func iterenaryButtonAction(_ sender: Any) {
        iternaryView.layer.borderColor = UIColor.clear.cgColor
        fareRulesView.layer.borderColor = HexColor("#ECECEC").cgColor
        bagInfoView.layer.borderColor = HexColor("#ECECEC").cgColor
        breakdownView.layer.borderColor = HexColor("#ECECEC").cgColor
        iternaryView.backgroundColor = HexColor("#B6BDC7")
        iternaryLabel.textColor = HexColor("#000000")
        fareRulesView.backgroundColor = HexColor("#FFFFFF")
        farerulesLabel.textColor = HexColor("#000000")
        breakdownView.backgroundColor = HexColor("#FFFFFF")
        breakDownLabel.textColor = HexColor("#000000")
        bagInfoView.backgroundColor = HexColor("#FFFFFF")
        bagInfoLabel.textColor = HexColor("#000000")
        setupItineraryOneWayTVCell()
    }
    
    @IBAction func bookNowButtonAction(_ sender: Any) {
        guard let vc = BookingDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.totalPrice1 = totalprice
        callapibool = true
        fdbool = true
        present(vc, animated: true)
    }
    
    
    @IBAction func fareRulesButtonAction(_ sender: Any) {
        fareRulesView.layer.borderColor = UIColor.clear.cgColor
        bagInfoView.layer.borderColor = HexColor("#ECECEC").cgColor
        iternaryView.layer.borderColor = HexColor("#ECECEC").cgColor
        breakdownView.layer.borderColor = HexColor("#ECECEC").cgColor
        fareRulesView.backgroundColor = HexColor("#B6BDC7")
        farerulesLabel.textColor = HexColor("#000000")
        iternaryView.backgroundColor = HexColor("#FFFFFF")
        iternaryLabel.textColor = HexColor("#000000")
        breakdownView.backgroundColor = HexColor("#FFFFFF")
        breakDownLabel.textColor = HexColor("#000000")
        bagInfoView.backgroundColor = HexColor("#FFFFFF")
        bagInfoLabel.textColor = HexColor("#000000")
        setupFareRulesOneWayTVCell()
        callFareRulesAPI()
    }
    
    @IBAction func bagInfoButtonAction(_ sender: Any) {
        bagInfoView.layer.borderColor = UIColor.clear.cgColor
        fareRulesView.layer.borderColor = HexColor("#ECECEC").cgColor
        iternaryView.layer.borderColor = HexColor("#ECECEC").cgColor
        breakdownView.layer.borderColor = HexColor("#ECECEC").cgColor
        bagInfoView.backgroundColor = HexColor("#B6BDC7")
        bagInfoLabel.textColor = HexColor("#000000")
        fareRulesView.backgroundColor = HexColor("#FFFFFF")
        farerulesLabel.textColor = HexColor("#000000")
        breakdownView.backgroundColor = HexColor("#FFFFFF")
        breakDownLabel.textColor = HexColor("#000000")
        iternaryView.backgroundColor = HexColor("#FFFFFF")
        iternaryLabel.textColor = HexColor("#000000")
        setUpBaggageInfo()
    }
    
    func setupFareRulesOneWayTVCell() {
        tablerow.removeAll()
        
        if fareRulesData.count > 0 {
            tablerow.append(TableRow(key: "fare", height: 50,cellType: .HeaderTableViewCell))
            self.commonTableView.estimatedRowHeight = 500
            self.commonTableView.rowHeight = 40
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            fareRulesData.forEach { i in
                tablerow.append(TableRow(title:i.rule_heading,subTitle: i.rule_content?.htmlToString,cellType:. FareRulesTVCell))
            }
            
            tablerow.append(TableRow(height: 70, cellType: .EmptyTVCell))
            
        }else {
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }
        tvLeading.constant = 0
        tvTraling.constant = 0
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    func setupItineraryOneWayTVCell() {
        tablerow.removeAll()
        fd.enumerated().forEach { (index, element) in
            tablerow.append(TableRow(title:"\(String(describing: index))",moreData:element,cellType:.ItineraryAddTVCell))
        }
        tablerow.append(TableRow(height:20,bgColor: HexColor("F9F8F8"),cellType: .EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        tvLeading.constant = 15
        tvTraling.constant = 15
    }
    
    //MARK: - show FARE RULES Content Btn Action
    override func showContentBtnAction(cell: FareRulesTVCell) {
        if dropdownBool == true {
            cell.show()
            dropdownBool = false
        }else {
            cell.hide()
            dropdownBool = true
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true)
//        self.navigationController?.popViewController(animated: false)
    }
    
}


extension FlightDetailsViewController {
    
    func callGetFlightDetailsAPI() {
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResultindex"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsourcekey) ?? "0"
        
        viewmodel1?.CALL_GET_FLIGHT_DETAILS_API(dictParam: payload)
        
    }
    
    func flightDetails(response: FDModel) {
        holderView.isHidden = false
        fd = response.flightDetails ?? []
        
        jd = response.journeySummary ?? []
        fareRulehtml = response.fareRulehtml ?? []
        totalprice = "\(response.priceDetails?.api_currency ?? "") : \(response.priceDetails?.grand_total ?? "")"
        grandTotal = totalprice
        setAttributedTextnew(str1: "\(response.priceDetails?.api_currency ?? "")",
                             str2: "\(response.priceDetails?.grand_total ?? "")",
                             lbl: currencyLabel,
                             str1font: .InterBold(size: 12),
                             str2font: .InterBold(size: 18),
                             str1Color: .WhiteColor,
                             str2Color: .WhiteColor)
        
        farerulerefkey = response.fare_rule_ref_key ?? ""
        farerulesrefcontent = response.farerulesref_content ?? ""
        jSummary = response.journeySummary ?? []
        
        thefareRules = response.custom_farerules
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
        
        DispatchQueue.main.async {[self] in
            callFareRulesAPI()
        }
        
        DispatchQueue.main.async {[self] in
            //            setupTVCells()
        }
        
        DispatchQueue.main.async {[self] in
            setupItineraryOneWayTVCell()
            //            setUpFareRules()
        }
    }
    
    
    //MARK: - callFareRulesAPI
    func callFareRulesAPI() {
        payload.removeAll()
        payload["fare_rule_ref_key"] = farerulerefkey
        payload["farerulesref_content"] = farerulesrefcontent
        
        fareruleViewModel?.CALL_GET_FARE_RULES_API(dictParam: payload)
    }
    
    func fareRulesDetails(response: FareRulesModel) {
        fareRulesData = response.data ?? []
        DispatchQueue.main.async {[self] in
            //            setUpFareRules()
        }
    }
}


extension FlightDetailsViewController {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
    }
    
    
    @objc func reloadTV() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    
    @objc func reload() {
        DispatchQueue.main.async {[self] in
            callGetFlightDetailsAPI()
            callFareRulesAPI()
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
    
    
}


extension FlightDetailsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            cell.show()
        }
        
        commonTableView.beginUpdates()
        commonTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FareRulesTVCell {
            cell.hide()
        }
        
    }
}
