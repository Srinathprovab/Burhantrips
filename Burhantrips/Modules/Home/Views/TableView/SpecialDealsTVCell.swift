//
//  SpecialDealsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class SpecialDealsTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLblView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dealsHolderView: UIView!
    @IBOutlet weak var bookingHolderView: UIView!
    @IBOutlet weak var specialDealsCV: UICollectionView!
    
    var itemCount = Int()
    var autoScrollTimer: Timer?
    var destinationImages = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stopAutoScroll()
    }
    
    override func updateUI() {
        //        specialDealsCV.reloadData()
//        titlelbl.text = cellInfo?.title
        
        if cellInfo?.key == "flights" {
            if topFlightDetails.count == 0 {
                specialDealsCV.setEmptyMessage("No Data Found")
            }else {
                specialDealsCV.restore()
                itemCount = topFlightDetails.count
                startAutoScroll()
            }
        } else {
            if topHotelDetails.count == 0 {
                specialDealsCV.setEmptyMessage("No Data Found")
            }else {
                specialDealsCV.restore()
                itemCount = topHotelDetails.count
                startAutoScroll()
            }
        }
        specialDealsCV.reloadData()
    }
    
    func setupUI() {
        
    }
    
    func setupCV() {
        let nib = UINib(nibName: "SpecialDealsCVCell", bundle: nil)
        specialDealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        specialDealsCV.delegate = self
        specialDealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        
        let width  = (specialDealsCV.frame.width - 60 * 2) / 2
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 190, height: 212)

        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        specialDealsCV.collectionViewLayout = layout
        specialDealsCV.backgroundColor = .clear
        specialDealsCV.showsHorizontalScrollIndicator = false
        specialDealsCV.bounces = false
    }
    
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc func scrollToNextItem() {
         
        
        guard itemCount > 0 else {
            return // No items in the collection view
        }
        
        let currentIndexPaths = specialDealsCV.indexPathsForVisibleItems.sorted()
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
        
        specialDealsCV.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }

}



extension SpecialDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellInfo?.key == "flights" {
            return topFlightDetails.count
        }else {
            return topHotelDetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SpecialDealsCVCell {
            
            if cellInfo?.key == "flights" {
//                cell.promoCodelbl.isHidden = true
                let data = topFlightDetails[indexPath.row]
                cell.offerImage.sd_setImage(with: URL(string: data.topFlightImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.bookinglbl.text = "\(data.to_city_name ?? "")"
//                cell.promoCodelbl.isHidden = true
            } else {
                let data = topHotelDetails[indexPath.row]
                cell.offerImage.sd_setImage(with: URL(string: data.topHotelImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                cell.bookinglbl.text = "\(data.country ?? "")"
//                cell.promoCodelbl.text =  "\(data.city_name ?? "")"
            }
            
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SpecialDealsCVCell {
            var userinfo = [String:Any]()
            if cellInfo?.key == "flights" {
                userinfo.removeAll()
                userinfo["trip_type"] = topFlightDetails[indexPath.row].trip_type ?? ""
                userinfo["fromFlight"] = topFlightDetails[indexPath.row].fromFlight ?? ""
                userinfo["from_city"] = topFlightDetails[indexPath.row].from_city ?? ""
                userinfo["toFlight"] = topFlightDetails[indexPath.row].toFlight ?? ""
                userinfo["to_city"] = topFlightDetails[indexPath.row].to_city ?? ""
                userinfo["travel_date"] = topFlightDetails[indexPath.row].travel_date ?? ""
                userinfo["return_date"] = topFlightDetails[indexPath.row].return_date ?? ""
                userinfo["airline_class"] = topFlightDetails[indexPath.row].airline_class ?? ""
                userinfo["from_city_name"] = topFlightDetails[indexPath.row].from_city_name ?? ""
                userinfo["to_city_name"] = topFlightDetails[indexPath.row].to_city_name ?? ""
                userinfo["from_city_loc"] = topFlightDetails[indexPath.row].from_city_loc ?? ""
                userinfo["to_city_loc"] = topFlightDetails[indexPath.row].to_city_loc ?? ""
                
                NotificationCenter.default.post(name: NSNotification.Name("topcity"), object: nil,userInfo: userinfo)
            } else {
                userinfo.removeAll()
                userinfo["city"] = topHotelDetails[indexPath.row].country ?? ""
                userinfo["hotel_code"] = topHotelDetails[indexPath.row].city ?? ""
                userinfo["check_in"] = topHotelDetails[indexPath.row].check_in ?? ""
                userinfo["check_out"] = topHotelDetails[indexPath.row].check_out ?? ""
                NotificationCenter.default.post(name: NSNotification.Name("tophotel"), object: nil,userInfo: userinfo)
                print("Hotel")
            }
        }
    }
    
}
