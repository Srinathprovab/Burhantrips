//
//  SelectRatingTVCell.swift
//  Travrun
//
//  Created by MA1882 on 20/12/23.
//

import UIKit

class SelectRatingTVCell: TableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var starCount = ["1", "2", "3", "4", "5"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = HexColor("#E6E8E7").cgColor
        contentView.layer.borderWidth = 1
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "RatingCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 45, height: 30)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 4
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        starCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = starCount[indexPath.row]
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RatingCollectionViewCell {
            commonCell = cell
            cell.countLabel.text = data
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? RatingCollectionViewCell
        cell?.starImage.image = UIImage(named: "star")
        cell?.holderView.backgroundColor = HexColor("#3C627A")
    }
}

