//
//  HotelListTVCellTableViewCell.swift
//  Travrun
//
//  Created by MA1882 on 26/12/23.
//

import UIKit

class HotelListTVCellTableViewCell: TableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionViewCell: UICollectionView!
    var starCount = ["1", "2", "3", "4", "5"]
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCV()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setUpCV() {
//        contentView.layer.cornerRadius = 8
//        contentView.layer.borderColor = HexColor("#E6E8E7").cgColor
//        contentView.layer.borderWidth = 1
        collectionViewCell.delegate = self
        collectionViewCell.bounces = false
        collectionViewCell.dataSource = self
        let nib = UINib(nibName: "RatingCollectionViewCell", bundle: nil)
        collectionViewCell.register(nib, forCellWithReuseIdentifier: "cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 14, height: 14)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewCell.collectionViewLayout = layout
        collectionViewCell.backgroundColor = .clear
        collectionViewCell.layer.cornerRadius = 4
        collectionViewCell.clipsToBounds = true
        collectionViewCell.showsHorizontalScrollIndicator = false
        collectionViewCell.allowsMultipleSelection = true
    }
    
}

extension HotelListTVCellTableViewCell {
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
            cell?.countLabel.textColor = UIColor.white
//            let starCount = cell?.countLabel.text
//            selectedItems.append(starCount ?? "0")
//            print("value is \(starCount ?? "1")")
//            print("Selected items: \(selectedItems)")
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let cell = collectionView.cellForItem(at: indexPath) as? RatingCollectionViewCell
            cell?.holderView.backgroundColor = .white
            cell?.starImage.image = UIImage(named: "star")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
            cell?.countLabel.textColor = .AppLabelColor
            let unselectedItem = cell?.countLabel.text ?? "0"
//            if let index = selectedItems.firstIndex(of: unselectedItem) {
//                print("index is: \(index)")
//                selectedItems.remove(at: index)
//            }
//            print("UnSelected items: \(selectedItems)")
        }
}
