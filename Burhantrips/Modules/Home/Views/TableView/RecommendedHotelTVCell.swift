//
//  RecommendedHotelTVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 12/01/24.
//

import UIKit

class RecommendedHotelTVCell: TableViewCell, UICollectionViewDelegateFlowLayout {
  
    @IBOutlet weak var hotelCV: UICollectionView!
    var itemCount = Int()
    var autoScrollTimer: Timer?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCV()
        // Initialization code
    }
    
    
    override func updateUI() {
        if topHotelDetails.count == 0 {
            hotelCV.setEmptyMessage("No Data Found")
        }else {
            hotelCV.restore()
            itemCount = topHotelDetails.count
            startAutoScroll()
        }
        hotelCV.reloadData()
    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "RecommendedHotelCVCell", bundle: nil)
        hotelCV.register(nib, forCellWithReuseIdentifier: "cell")
        hotelCV.delegate = self
        hotelCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        
        let width  = 366
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: 222)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        hotelCV.collectionViewLayout = layout
        hotelCV.backgroundColor = .clear
        hotelCV.showsHorizontalScrollIndicator = false
        hotelCV.bounces = false
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc func scrollToNextItem() {
         
        
        guard itemCount > 0 else {
            return // No items in the collection view
        }
        
        let currentIndexPaths = hotelCV.indexPathsForVisibleItems.sorted()
        let lastIndexPath = currentIndexPaths.last ?? IndexPath(item: 0, section: 0)
        
        var nextIndexPath: IndexPath
        
        if lastIndexPath.item == itemCount - 1 {
            nextIndexPath = IndexPath(item: 0, section: lastIndexPath.section)
        } else {
            nextIndexPath = IndexPath(item: lastIndexPath.item + 1, section: lastIndexPath.section)
        }
        
        if nextIndexPath.item >= itemCount {
            nextIndexPath = IndexPath(item: 0, section: nextIndexPath.section) // Adjust the index path if it exceeds the bounds
        }
        
        hotelCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
}

extension RecommendedHotelTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return topHotelDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecommendedHotelCVCell {
                let data = topHotelDetails[indexPath.row]
            cell.starVal = Int(data.rating ?? "0") ?? 0
            
                cell.cityImage.sd_setImage(with: URL(string: data.topHotelImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.titleLabel.text = "\(data.city ?? "")"
            commonCell = cell
        }
        return commonCell
    }
}
