//
//  TopCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class TopCityTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var citysCV: UICollectionView!
    
    var topHotelsImages = ["banner1", "banner2", "banner1", "banner2"]
    var popularDestinationsImages = ["banner3", "banner4", "banner3", "banner4"]
    var topHotels = ["Dubai", "Riyadh", "Dubai", "Riyadh"]
    var popularDestinations = ["Dubai", "Kuwait", "Dubai", "Kuwait"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
//        titlelbl.text = cellInfo?.title
        citysCV.reloadData()
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
//        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: UIFont.latoSemiBold(size: 18), align: .left)
        setupCV()
        
    }
    
    func setupCV() {
        citysCV.bounces = false
        let nib = UINib(nibName: "TopCityCVCell", bundle: nil)
        citysCV.register(nib, forCellWithReuseIdentifier: "cell")
        citysCV.delegate = self
        citysCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 153)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 18
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        citysCV.collectionViewLayout = layout
//        citysCV.backgroundColor = .clear
//        citysCV.layer.cornerRadius = 4
//        citysCV.clipsToBounds = true
        citysCV.showsHorizontalScrollIndicator = false
    }
    
    
    
}


extension TopCityTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topHolidayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        let data = topHolidayList[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopCityCVCell {
            cell.cityImage.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            cell.cityNamelbl.text = data.city_name
            commonCell = cell
        }
        return commonCell
    }
    
}

