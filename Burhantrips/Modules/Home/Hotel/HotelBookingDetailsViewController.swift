//
//  HotelBookingDetailsViewController.swift
//  Travrun
//
//  Created by MA1882 on 26/12/23.
//

import UIKit

class HotelBookingDetailsViewController: BaseTableVC {
    
    @IBOutlet weak var backButtonView: UIView!
    var tablerow = [TableRow]()
    var HotelBookingViewModel: HotelBookingDetailsViewModel?
    
    static var newInstance: HotelBookingDetailsViewController? {
        let storyboard = UIStoryboard(name: Storyboard.SearchHotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelBookingDetailsViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTVCells()
        commonTableView.registerTVCells(["BookingDetailsCardTVCellTableViewCell",
                                         "EmptyTVCell", "RegisterSelectionLoginTableViewCell", "GuestRegisterTableViewCell", "RegisterNowTableViewCell", "LoginDetailsTableViewCell", "AddAdultTableViewCell", "FareSummaryTableViewCell", "AcceptTermsAndConditionTVCell", "HeaderTableViewCell", "AddressTableViewCell", "HotelFareSummeryTableViewCell", "GuestDetailsTVCell", "HotelListTVCellTableViewCell"])
        // Do any additional setup after loading the view.
    }
    
    func setupTVCells() {
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .HotelListTVCellTableViewCell))
        if defaults.bool(forKey: UserDefaultsKeys.loggedInStatus) == false {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
            tablerow.append(TableRow(cellType: .RegisterSelectionLoginTableViewCell))
            tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            if HotelBookingViewModel?.section == .guestLogin {
                tablerow.append(TableRow(cellType: .GuestRegisterTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            } else if HotelBookingViewModel?.section == .register {
                tablerow.append(TableRow(cellType: .LoginDetailsTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            } else if HotelBookingViewModel?.section == .login {
                tablerow.append(TableRow(key: "register",cellType: .RegisterNowTableViewCell))
                tablerow.append(TableRow(height: 12, cellType:.EmptyTVCell))
            }
        } else {
            tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        }
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .GuestRegisterTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .GuestDetailsTVCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(title: "AddAdult", cellType: .HeaderTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(cellType: .HotelFareSummeryTableViewCell))
        tablerow.append(TableRow(height: 14, cellType:.EmptyTVCell))
        tablerow.append(TableRow(height: 100, bgColor: .white, cellType: .AcceptTermsAndConditionTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: false)
    }
    
}
