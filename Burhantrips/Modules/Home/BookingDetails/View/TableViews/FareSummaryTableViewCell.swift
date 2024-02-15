//
//  FareSummaryTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 04/12/23.
//

import UIKit

protocol FareSummaryTableViewCellDelegate {
   func travListButtonAction()
}

class FareSummaryTableViewCell: TableViewCell, UITableViewDelegate, UITableViewDataSource, FareTableViewCellDelegate {
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalDisountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var delegate: FareSummaryTableViewCellDelegate?
    var isOpen = true
    
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FareTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        // Initialization code
        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
        totalLabel.text = grandTotal
        subTotalLabel.text = grandTotal
//        totalDisountLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension FareSummaryTableViewCell {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FareTableViewCell
        cell.delegate = self
        if indexPath.row == 0 {
            cell.titleLabel.text = "Traveller x \(adultsCount) Adult"
            cell.subTitleLabel.text = AdultsTotalPrice
            return cell
        } else  if indexPath.row == 1 {
            cell.titleLabel.text = "Traveller x \(childCount) Child"
            cell.subTitleLabel.text = ChildTotalPrice
            return cell
        } else  if indexPath.row == 2 {
            cell.titleLabel.text = "Traveller x \(infantsCount) Infant"
            cell.subTitleLabel.text = InfantTotalPrice
            return cell
        }
        return TableViewCell()
    }

    func travInfoButtonTappe(cell: FareTableViewCell) {
        self.isOpen.toggle()
        if isOpen {
            cell.bottomView.isHidden = true
            tableView.reloadData()
        } else {
            cell.bottomView.isHidden = false
            tableView.reloadData()
        }
    }
    
}


