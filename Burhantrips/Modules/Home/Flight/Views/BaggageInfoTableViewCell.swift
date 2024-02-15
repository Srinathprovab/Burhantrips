//
//  BaggageInfoTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 24/11/23.
//

import UIKit

class BaggageInfoTableViewCell: TableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var bagInfo = [JourneySummary]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "BaggageInfoCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        let width = collectionView.frame.width / 2
        layout.itemSize = CGSize(width: width, height: 143)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 4
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func updateUI() {
        bagInfo = cellInfo?.moreData as! [JourneySummary]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension BaggageInfoTableViewCell{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bagInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = bagInfo[indexPath.row]
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BaggageInfoCollectionViewCell {
            commonCell = cell
            cell.cityLabel.text = "\(data.from_city ?? "") to \(data.to_city ?? "")"
//            cell.numberOfPieceLabel.text = data.cabin_baggage
            cell.titleLabel.text = "\(data.cabin_baggage ?? "0") cabin baggage"
            cell.subTitleLabel.text = "Checked Baggage Included \(data.cabin_baggage ?? "0")"
            cell.baggageInfoLabel.text = "\(data.weight_Allowance ?? "0")"
            if bagInfo.count == 1 {
                cell.separatorView.isHidden = true
            } else if bagInfo.count > 1  {
                cell.separatorView.isHidden = false
            }
        }
        return commonCell
    }
}


