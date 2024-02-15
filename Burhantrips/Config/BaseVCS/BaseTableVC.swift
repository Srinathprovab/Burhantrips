//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit

class BaseTableVC: UIViewController, ButtonTVCellDelegate, OneWayTableViewCellDelegate, NewFlightSearchResultTVCellDelegate, FlightSearchButtonTableViewCellDelegate, SortbyTVCellDelegate, CheckBoxTVCellDelegate, SliderTVCellDelegate, RegisterSelectionLoginTableViewCellDelegate, LabelTVCellDelegate, RegisterUserTVCellDelegate, UnderLineTVCellPrtocal, TextfieldTVCellDelegate, MenuBGTVCellDelegate, SideMenuTitleTVCellDelegate, SelectGenderTVCellDelegate, RegisterNowTableViewCellDelegate, LoginDetailsTableViewCellDelegate, AddAdultTableViewCellDelegate, FareSummaryTableViewCellDelegate, SearchHotelTVCellDelegate, AddRoomsGuestsTVCellDelegate, CommonFromCityTVCellDelegate, HotelsTVCellelegate, SearchLocationTFTVCellDelegate, BookFlightDetailsTVCellDelegate, TDetailsLoginTVCellDelegate, AddDeatilsOfTravellerTVCellDelegate, TravelInsuranceTVCellDelegate, ContactInformationTVCellDelegate, UsePromoCodesTVCellDelegate, PriceSummaryTVCellDelegate, SpecialRequestTVCellDelegate, ViewFlightDetailsBtnTVCellDelegate, AddAdultsOrGuestTVCellDelegate, SearchFlightResultTVCellDelegate, TitleLblTVCellDelegate, RadioButtonTVCellDelegate, FareRulesTVCellDelegate, AboutusTVCellDelegate, sideMenuOptionsTVCellDelegate, TravellerEconomyTVCellDelegate, DuriationSliderTVCellDelegate, AddonTableViewCellDelegate, AcceptTermsAndConditionTVCellDelegate, VocherFlightDetailsTVCellDelegate, ContactUsLabelTVCellDelegate, SendUsMessageTVCellDelegate, MapViewTVCellDelegate, ContactUsTVCellDelegate {
   
   
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    
    var commonTVData = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.isHidden = true
        configureTableView()
        //        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTableView() {
        if commonTableView != nil {
            makeDefaultConfigurationForTable(tableView: commonTableView)
        } else {
            print("commonTableView is nil")
        }
    }
    
    func makeDefaultConfigurationForTable(tableView: UITableView) {
        
        tableView.bounces = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func serviceCall_Completed_ForNoDataLabel(noDataMessage: String? = nil, data: [Any]? = nil, centerVal:CGFloat? = nil, color: UIColor = HexColor("#182541")) {
        dealWithNoDataLabel(message: noDataMessage, data: data, centerVal: centerVal ?? 2.0, color: color)
    }
    
    func dealWithNoDataLabel(message: String?, data: [Any]?, centerVal: CGFloat = 2.0, color: UIColor = HexColor("#182541")) {
        if commonTableView == nil { return; }
        
        commonTableView.viewWithTag(100)?.removeFromSuperview()
        
        if let message = message, let data = data {
            if data.count == 0 {
                let tableSize = commonTableView.frame.size
                
                let label = UILabel(frame: CGRect(x: 15, y: 15, width: tableSize.width, height: 60))
                label.center = CGPoint(x: (tableSize.width/2), y: (tableSize.height/centerVal))
                label.tag = 100
                label.numberOfLines = 0
                
                label.textAlignment = NSTextAlignment.center
                //                label.font = UIFont.CircularStdMedium(size: 14)
                label.textColor = color
                label.text = message
                
                commonTableView.addSubview(label)
            }
        }
        
    }
    
    //Delegate Methods
    func didTapOnAddressBtnAction(cell: ContactUsTVCell) {}
    func didTapOnMailBtnAction(cell: ContactUsTVCell) {}
    func didTapOnPhoneBtnAction(cell: ContactUsTVCell) {}
    func didTapOnSubmitBtnAction(cell: ContactUsTVCell) {}
    func didTapOnMapImgBtnAction(cell: MapViewTVCell) {}
    func didTapOnSubmitBtn(cell: SendUsMessageTVCell) {}
    func didTapOnCountryCodeSelectBtn(cell: SendUsMessageTVCell) {}
    func textViewDidChange(textView: UITextView) {}
    func didTapOnOpenEmailButtonAction(cell: ContactUsLabelTVCell) {}
    func didTapOnViewVocherBtn(cell: VocherFlightDetailsTVCell) {}
    func didTapOnTAndCAction(cell: AcceptTermsAndConditionTVCell) {}
    func didTapOnPrivacyPolicyAction(cell: AcceptTermsAndConditionTVCell) {}
    func didDeselectAddon(index: Int) {}
    func didSelectAddon(index: Int) {}
    func didTapOnShowSliderBtn(cell: DuriationSliderTVCell) {}
    func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {}
    func didTapOnaddToCityButton(cell: OneWayTableViewCell) {}
    func didTapOnaddFromCityButton(cell: OneWayTableViewCell) {}
    func didTapOnMenuOptionBtn(cell: sideMenuOptionsTVCell) {}
    func showContentBtnAction(cell: FareRulesTVCell) {}
    func travListButtonAction() {}
    func didTapOnAddReturnFlightAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnLoginBtn(cell: MenuBGTVCell) {}
    func didTapOnEditProfileBtn(cell: MenuBGTVCell) {}
    func didTapOnForGetPassword(cell: TextfieldTVCell) {}
    func didTapOnShowPasswordBtn(cell: TextfieldTVCell) {}
    func donedatePicker(cell: TextfieldTVCell) {}
    func cancelDatePicker(cell: TextfieldTVCell) {}
    func textFieldText(cell: TextfieldTVCell, text: String) {}
    func didTapOnCountryCodeBtn(cell: TextfieldTVCell) {}
    func didTapOnflightDetailsButton(cell: NewFlightSearchResultTVCell) {}
    func didTapOnCloseReturnView(cell: OneWayTableViewCell) {}
    func didTapOnReturnToOnewayBtnAction(cell: OneWayTableViewCell) {}
    func didTapOnAddReturnFlight(cell: OneWayTableViewCell) {}
    func didTapOnflightSearchBtnAction(cell: FlightSearchButtonTableViewCell) {}
    func btnAction(cell: ButtonTVCell) {}
    func didTapOnDualBtn1(cell: ButtonTVCell) {}
    func didTapOnDualBtn2(cell: ButtonTVCell) {}
    func didTapOnFlightDetailsBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnBookNowBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnAddReturnFlightBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnMoreSimilarBtnAction(cell: NewFlightSearchResultTVCell) {}
    func didTapOnAdvanedSearchOptions(cell: OneWayTableViewCell) {}
    func didTapOnButton(cell: ButtonTVCell) {}
    func editingChanged(tf: UITextField) {}
    func didTapOnDepartureBtnAction(cell: OneWayTableViewCell) {}
    func didTapOnReturnBtnAction(cell: OneWayTableViewCell) {}
    func editingTextField(tf: UITextField) {}
    func didTapOnCheckBoxDropDownBtn(cell: CheckBoxTVCell) {}
    func didTapOnShowMoreBtn(cell: CheckBoxTVCell) {}
    func didTapOnCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnDeselectCheckBox(cell: checkOptionsTVCell) {}
    func didTapOnLowtoHighBtn(cell: SortbyTVCell) {}
    func didTapOnHightoLowBtn(cell: SortbyTVCell) {}
    func didTapOnShowSliderBtn(cell: SliderTVCell) {}
    func didTapOnguestButton(cell: RegisterSelectionLoginTableViewCell) {}
    func registerButton(cell: RegisterSelectionLoginTableViewCell) {}
    func loginButton(cell: RegisterSelectionLoginTableViewCell) {}
    func didTapOnCloseBtn(cell: LabelTVCell) {}
    func didTapOnShowMoreBtn(cell: LabelTVCell) {}
    func didTapOnCountryCodeBtnAction(cell: RegisterUserTVCell) {}
    func didTapOnLoginBtn(cell: UnderLineTVCell) {}
    func didTapOnSignUpBtn(cell: UnderLineTVCell) {}
    func didTaponCell(cell: SideMenuTitleTVCell) {}
    func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {}
    func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {}
    func didSelectOnOthersBtn(cell: SelectGenderTVCell) {}
    func didTapOnSaveBtn(cell: SelectGenderTVCell) {}
    func loginNowButtonAction(cell: RegisterNowTableViewCell, email: String, pass: String) {}
    func RegisterNowButtonAction(cell: LoginDetailsTableViewCell, email: String, pass: String, phone: String) {}
    func didTaponSwitchButton(cell: AddAdultTableViewCell) {}
    func didTaponPassangerButton(cell: AddAdultTableViewCell) {}
    func didTapOnCheckinBtn(cell: SearchHotelTVCell) {}
    func didTapOnCheckoutBtn(cell: SearchHotelTVCell) {}
    func didTapOnAddRoomsAndGuestBtn(cell: SearchHotelTVCell) {}
    func didTapOnSearchHotelBtn(cell: SearchHotelTVCell) {}
    func didTapOnSearchHotelCityBtn(cell: SearchHotelTVCell) {}
    func didTapOnSelectCountryCodeList(cell: SearchHotelTVCell) {}
    func closeBtnAction(cell: AddRoomsGuestsTVCell) {}
    func adultsIncrementButtonAction(cell: AddRoomsGuestsTVCell) {}
    func adultsDecrementBtnAction(cell: AddRoomsGuestsTVCell) {}
    func childrenIncrementButtonAction(cell: AddRoomsGuestsTVCell) {}
    func childrenDecrementBtnAction(cell: AddRoomsGuestsTVCell) {}
    func viewBtnAction(cell: CommonFromCityTVCell) {}
    func didTapOnDual1Btn(cell: CommonFromCityTVCell) {}
    func didTapOnDual2Btn(cell: CommonFromCityTVCell) {}
    func didTapOnTermsAndConditionBtn(cell: HotelsTVCell) {}
    func didTapOnBookNowBtnAction(cell: HotelsTVCell) {}
    func mapViewBtnAction(cell: SearchLocationTFTVCell) {}
    func didTapOnviewFlifgtDetailsBtn(cell: BookFlightDetailsTVCell) {}
    func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {}
    func didTapOnExpandAdultViewbtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func tfeditingChanged(tf: UITextField) {}
    func didTapOnTitleBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMrBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMrsBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMissBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSaveTravellerDetailsBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func editingMDCOutlinedTextField(tf: UITextField) {}
    func donedatePicker(cell: AddDeatilsOfTravellerTVCell) {}
    func cancelDatePicker(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSelectNationalityBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSelectIssuingCountryBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnMealPreferenceBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnSpecialAssicintenceBtn(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnFlyerProgramBtnAction(cell: AddDeatilsOfTravellerTVCell) {}
    func didTapOnInsureSkipButton(cell: TravelInsuranceTVCell) {}
    func didTapOnPABtn(cell: TravelInsuranceTVCell) {}
    func didTapOnTCBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnTDBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnTC1Btn(cell: TravelInsuranceTVCell) {}
    func didTapOnTD1Btn(cell: TravelInsuranceTVCell) {}
    func didTapOnShowMoreBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnYesInsureBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnNoInsureBtn(cell: TravelInsuranceTVCell) {}
    func didTapOnCountryCodeBtn(cell: ContactInformationTVCell) {}
    func didTapOnDropDownBtn(cell: ContactInformationTVCell) {}
    func didTapOnViewAllPromoCodesBtn(cell: UsePromoCodesTVCell) {}
    func didTapOnApplyPromosCodesBtn(cell: UsePromoCodesTVCell) {}
    func didTapOnRemoveTravelInsuranceBtn(cell: PriceSummaryTVCell) {}
    func didTapOnTAndCAction(cell: SpecialRequestTVCell) {}
    func didTapOnPrivacyPolicyAction(cell: SpecialRequestTVCell) {}
    func didTapOnViewFlightDetailsButton(cell: ViewFlightDetailsBtnTVCell) {}
    func didTapOnEditAdultBtn(cell: AddAdultsOrGuestTVCell) {}
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {}
    func didTapOnOptionBtn(cell: AddAdultsOrGuestTVCell) {}
    func didTapOnViewVoucherBtn(cell: SearchFlightResultTVCell) {}
    func didTapOnBookNowBtn(cell: SearchFlightResultTVCell) {}
    func didTapOnFlightDetailsBtnAction(cell: SearchFlightResultTVCell) {}
    func didTapOnSimilarFlightsButtonAction(cell: SearchFlightResultTVCell) {}
    func didTapOnEditBtn(cell: TitleLblTVCell) {}
    func didTapOnRadioButton(cell: RadioButtonTVCell) {}
    func didTapOnAboutUsLink(cell: AboutusTVCell) {}
    func didTapOnTermsLink(cell: AboutusTVCell) {}
    func didTapOnCoockiesLink(cell: AboutusTVCell) {}
    func didTapOnContactUs(cell: AboutusTVCell) {}
    func didTapOnaddEconomyButton(cell: OneWayTableViewCell) {}
    
}

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = commonTVData[indexPath.row].height
        
        if let height = height {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commonTableView {
            return commonTVData.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell: TableViewCell!
        
        var data: TableRow?
        var commonTV = UITableView()
        
        if tableView == commonTableView {
            data = commonTVData[indexPath.row]
            commonTV = commonTableView
        }
        
        
        if let cellType = data?.cellType {
            switch cellType {

                // homme page TVCells
            case .SpecialDealsTVCell:
                let cell: SpecialDealsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell


            case .TopCityTVCell:
                let cell: TopCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell

            case .EmptyTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell

            case .TextfieldTVCell:
                let cell: TextfieldTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell

            case .ButtonTVCell:
                let cell: ButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
            
            case .SideMenuTitleTVCell:
                let cell: SideMenuTitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell

            case .MenuBGTVCell:
                let cell: MenuBGTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .QuickLinkTableViewCell:
                let cell: QuickLinkTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .holidayTableViewCell:
                let cell: holidayTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .SelectLanguageTVCell:
                let cell: SelectLanguageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .OneWayTableViewCell:
                let cell: OneWayTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .NewFlightSearchResultTVCell:
                let cell: NewFlightSearchResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FlightSearchButtonTableViewCell:
                let cell:  FlightSearchButtonTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .FlightInfoTableViewCell:
                let cell:  FlightInfoTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .FareBreakDownTableViewCell:
                let cell:  FareBreakDownTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .totalDiscountTVCell:
                let cell:  totalDiscountTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .FareRulesTableViewCell:
                let cell:  FareRulesTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .BaggageInfoTableViewCell:
                let cell:  BaggageInfoTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .ContactUsLabelTVCell:
                let cell:  ContactUsLabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .HeaderTableViewCell:
                let cell:  HeaderTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .HeaderSubHeaderTVCellTableViewCell:
                let cell:  HeaderSubHeaderTVCellTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .BCFlightInfoTVCell:
                let cell:  BCFlightInfoTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .PassangerDetailsTableViewCell:
                let cell:  PassangerDetailsTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .ImportentInfoTableViewCell:
                let cell:  ImportentInfoTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .TermsAndConditionTableViewCell:
                let cell: TermsAndConditionTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .SortTableViewCell:
                let cell: SortTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .CheckBoxTVCell :
                let cell: CheckBoxTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SortbyTVCell :
                let cell: SortbyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .SliderTVCell :
                let cell: SliderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .BookingDetailsCardTVCellTableViewCell :
                let cell: BookingDetailsCardTVCellTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .RegisterSelectionLoginTableViewCell :
                let cell: RegisterSelectionLoginTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .GuestRegisterTableViewCell :
                let cell: GuestRegisterTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .RegisterNowTableViewCell :
                let cell: RegisterNowTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .LoginDetailsTableViewCell :
                let cell: LoginDetailsTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AdultTableViewCell :
                let cell: AdultTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .FareSummaryTableViewCell :
                let cell: FareSummaryTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .AcceptTermsAndConditionTVCell :
                let cell: AcceptTermsAndConditionTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .LabelTVCell :
                let cell: LabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .RegisterUserTVCell :
                let cell: RegisterUserTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .UnderLineTVCell :
                let cell: UnderLineTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .AddAdultTableViewCell :
                let cell: AddAdultTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .SelectGenderTVCell :
                let cell: SelectGenderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .AddressTableViewCell :
                let cell: AddressTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
             
            case .ItineraryAddTVCell :
                let cell: ItineraryAddTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .SearchHotelTVCell :
                let cell: SearchHotelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .SelectRatingTVCell:
                let cell: SelectRatingTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AddRoomsGuestsTVCell:
                let cell: AddRoomsGuestsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .CommonFromCityTVCell:
                let cell: CommonFromCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .HotelsTVCell:
                let cell: HotelsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .SearchLocationTFTVCell:
                let cell: SearchLocationTFTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .HotelListTVCellTableViewCell:
                let cell: HotelListTVCellTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .HotelFareSummeryTableViewCell:
                let cell: HotelFareSummeryTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .GuestDetailsTVCell:
                let cell: GuestDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
           
            case .BookFlightDetailsTVCell:
                let cell: BookFlightDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .TDetailsLoginTVCell:
                let cell: TDetailsLoginTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .AddDeatilsOfTravellerTVCell:
                let cell: AddDeatilsOfTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .TravelInsuranceTVCell:
                let cell: TravelInsuranceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .ContactInformationTVCell:
                let cell: ContactInformationTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .UsePromoCodesTVCell:
                let cell: UsePromoCodesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .PriceSummaryTVCell:
                let cell: PriceSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .SpecialRequestTVCell:
                let cell: SpecialRequestTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .TotalNoofTravellerTVCell:
                let cell: TotalNoofTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .ViewFlightDetailsBtnTVCell:
                let cell: ViewFlightDetailsBtnTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .AddAdultsOrGuestTVCell:
                let cell: AddAdultsOrGuestTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .SearchFlightResultTVCell:
                let cell: SearchFlightResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .TitleLblTVCell:
                let cell: TitleLblTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .RadioButtonTVCell:
                let cell: RadioButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .BookingConfirmedTVCell:
                let cell: BookingConfirmedTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .BCFlightDetailsTVCell:
                let cell: BCFlightDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .BookedTravelDetailsTVCell:
                let cell: BookedTravelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .RecommendedHotelTVCell:
                let cell: RecommendedHotelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .BestPriceTVCell:
                let cell: BestPriceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .NewBaggageTVCell:
                let cell: NewBaggageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .FareRulesTVCell:
                let cell: FareRulesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .MenuTitleTVCell:
                let cell: MenuTitleTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
               
                
            case .checkOptionsTVCell:
                let cell: checkOptionsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .AboutusTVCell:
                let cell: AboutusTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .sideMenuOptionsTVCell:
                let cell: sideMenuOptionsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .NewFromCityTVCell:
                let cell: NewFromCityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .TravellerEconomyTVCell:
                let cell: TravellerEconomyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .CommonTVCell:
                let cell: CommonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
            case .AddonTableViewCell:
                let cell: AddonTableViewCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .DuriationSliderTVCell:
                let cell: DuriationSliderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .VocherFlightDetailsTVCell:
                let cell: VocherFlightDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .SendUsMessageTVCell:
                let cell: SendUsMessageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .MapViewTVCell:
                let cell: MapViewTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .NewAboutUsTVCell:
                let cell: NewAboutUsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
        
                
            case .ContactUsTVCell:
                let cell: ContactUsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
        
                
                
             
            default:
                print("handle this case in getCurrentCellAt")
            }
        }
        
        commonCell.cellInfo = data
        commonCell.indexPath = indexPath
        commonCell.selectionStyle = .none
        
        return commonCell
    }
} 

extension UITableView {
    func registerTVCells(_ classNames: [String]) {
        for className in classNames {
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeTVCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func dequeTVCellForFooter<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func isLast(for indexPath: IndexPath) -> Bool {
        
        let indexOfLastSection = numberOfSections > 0 ? numberOfSections - 1 : 0
        let indexOfLastRowInLastSection = numberOfRows(inSection: indexOfLastSection) - 1
        
        return indexPath.section == indexOfLastSection && indexPath.row == indexOfLastRowInLastSection
    }

}
