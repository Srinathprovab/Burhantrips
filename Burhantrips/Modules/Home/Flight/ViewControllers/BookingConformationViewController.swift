//
//  BookingConformationViewController.swift
//  Travrun
//
//  Created by MA1882 on 27/11/23.
//

import UIKit

class BookingConformationViewController: BaseTableVC {
    @IBOutlet weak var backButtonView: BorderedView!
    static var newInstance: BookingConformationViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConformationViewController
        return vc
    }
    
    var tableRow = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        registerTv()
        setUpTV()
    }
    
    func registerTv() {
        self.commonTableView.registerTVCells(["HeaderSubHeaderTVCellTableViewCell", "BCFlightInfoTVCell", "HeaderTableViewCell", "PassangerDetailsTableViewCell", "ImportentInfoTableViewCell", "EmptyTVCell", "TermsAndConditionTableViewCell"])
    }
    
   func setUpTV() {
        tableRow.removeAll()
        tableRow.append(TableRow(cellType: .HeaderSubHeaderTVCellTableViewCell))
        tableRow.append(TableRow(cellType: .BCFlightInfoTVCell))
        tableRow.append(TableRow(key: "Passenger(s) Details", height: 52, cellType: .HeaderTableViewCell))
        tableRow.append(TableRow(cellType: .PassangerDetailsTableViewCell))
       tableRow.append(TableRow(key: "Important Information", height: 52, cellType: .HeaderTableViewCell))
       tableRow.append(TableRow(cellType: .ImportentInfoTableViewCell))
       tableRow.append(TableRow(height: 11, cellType: .EmptyTVCell))
       tableRow.append(TableRow(title: "Check-in: Desks are generally open 3 hours before departure and are closed one hour before departure.", key: "checkin", height: 38,cellType: .HeaderTableViewCell))
       tableRow.append(TableRow(title: "Travel documents: A valid passport, National ID, Visa, and any travel document required according to the case.", key: "checkin", height: 38,cellType: .HeaderTableViewCell))
       tableRow.append(TableRow(title: "Travrun Applicable Processing or Service fees are Non-refundable", key: "checkin", height: 20,cellType: .HeaderTableViewCell))
       tableRow.append(TableRow(title: "Seat selection: Can be done through our contact centre if available by the Airline", key: "checkin", height: 38,cellType: .HeaderTableViewCell))
       tableRow.append(TableRow(title: "Online Checkin: Available 24 hours before departure through the Airline’s website", key: "checkin", height: 38,cellType: .HeaderTableViewCell))
       tableRow.append(TableRow(title: "Boarding pass: Available 24 hours before departure through the Airline’s website.", key: "checkin", height: 38,cellType: .HeaderTableViewCell))
       tableRow.append(TableRow(cellType: .TermsAndConditionTableViewCell))
       
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
