//
//  NewBaggageTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 18/01/24.
//

import UIKit

class NewBaggageTVCell: TableViewCell, UITableViewDataSource, UITableViewDelegate {
    var bagInfo = [JourneySummary]()
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "NewBaggageInfoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        // Initialization code
    }
    
    override func updateUI() {
        bagInfo = cellInfo?.moreData as! [JourneySummary]
        tableViewHeight.constant =  CGFloat(bagInfo.count * 140)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension NewBaggageTVCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bagInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        let data = bagInfo[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewBaggageInfoTableViewCell {
            cell.titleLabel.text = "\(data.from_city ?? "") to \(data.to_city ?? "")"
            cell.baggageLabel.text = "Cabin baggage - \(data.cabin_baggage ?? "0")"
            cell.checkdInLabel.text = "CheckIn Baggage - \(data.cabin_baggage ?? "0")"
            ccell = cell
        }
        return ccell
    }
}
