//
//  holidayTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 16/11/23.
//

import UIKit

class holidayTableViewCell: TableViewCell {
    
    @IBOutlet weak var holidayCollectionView: UICollectionView!
    var destinations = ["Maldives", "Bali", "Maldives", "Bali"]
    var holidayDestinationImages = ["banner5", "banner6", "banner7", "banner8"]
    var ticketFare = ["Start  from AED 250", "Start  from AED 500", "Start  from AED 750", "Start  from AED 1000"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCV()
        // Initialization code
       
    }
    
    override func updateUI() {
        holidayCollectionView.reloadData()
    }
    
    
    func setupCV() {
        holidayCollectionView.bounces = false
        let nib = UINib(nibName: "SpecialDealsCVCell", bundle: nil)
        holidayCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        holidayCollectionView.delegate = self
        holidayCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        let width = (self.holidayCollectionView.frame.size.width - 16 * 2) / 2
        layout.itemSize = CGSize(width: 190, height: 155)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        holidayCollectionView.collectionViewLayout = layout
        holidayCollectionView.backgroundColor = .clear
        holidayCollectionView.showsVerticalScrollIndicator = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}


extension holidayTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topHolidayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SpecialDealsCVCell {
       
            let data = topHolidayList[indexPath.row]
            cell.offerImage.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
//            cell.offerImage.image = UIImage(named: "banner5")
            cell.bookinglbl.text =  data.country_name
//            cell.promoCodelbl.isHidden = true
            commonCell = cell
        }
        return commonCell
    }
    
}
