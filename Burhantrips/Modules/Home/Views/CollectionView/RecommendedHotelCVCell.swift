//
//  RecommendedHotelCVCell.swift
//  Burhantrips
//
//  Created by MA1882 on 12/01/24.
//

import UIKit

class RecommendedHotelCVCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var starsCV: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityBgView: UIView!
    @IBOutlet weak var cityImage: UIImageView!
    
    var starVal = Int()
    override func awakeFromNib() {
        titleLabel.layer.cornerRadius = 2
        titleLabel.backgroundColor = .AppLabelColor.withAlphaComponent(0.3)
        cityBgView.layer.cornerRadius = 8
        cityImage.layer.cornerRadius = 8
        setupCV()
//        starVal = Int(rating) ?? 0
//        cityBgView.addCornerRadiusWithShadow(color: .AppLabelColor, borderColor: .clear, cornerRadius: 8)
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCV() {
        let nib = UINib(nibName: "RatingCVCell", bundle: nil)
        starsCV.register(nib, forCellWithReuseIdentifier: "cell")
        starsCV.delegate = self
        starsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 14, height: 13)
        layout.minimumInteritemSpacing = 4.59
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        starsCV.collectionViewLayout = layout
        starsCV.backgroundColor = .clear
        starsCV.showsHorizontalScrollIndicator = false
        starsCV.bounces = false
    }

}

extension RecommendedHotelCVCell {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return starVal
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RatingCVCell {
            commonCell = cell
        }
        return commonCell
    }
    
}
