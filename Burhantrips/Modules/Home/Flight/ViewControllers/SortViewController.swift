//
//  SortViewController.swift
//  Travrun
//
//  Created by MA1882 on 29/11/23.
//

import UIKit

class SortViewController: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    var lastContentOffset: CGFloat = 0
    static var newInstance: SortViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SortViewController
        return vc
    }
    
    var tableRow = [TableRow]()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTV()
        setUpTV()
        holderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        holderView.layer.cornerRadius = 30
        holderView.clipsToBounds = true
    }
    
    func registerTV() {
        self.commonTableView.registerTVCells(["SortTableViewCell"])
    }
    
    
    func setUpTV() {
        tableRow.removeAll()
        tableRow.append(TableRow(title: "Price", key: "Price",cellType: .SortTableViewCell))
        tableRow.append(TableRow(title: "Departure time", key: "Departure",cellType: .SortTableViewCell))
        tableRow.append(TableRow(title: "Arrival Time", key: "Arrival",cellType: .SortTableViewCell))
        tableRow.append(TableRow(title: "Duration", key: "Duration",cellType: .SortTableViewCell))
        self.commonTVData = tableRow
        self.commonTableView.reloadData()
    }
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
