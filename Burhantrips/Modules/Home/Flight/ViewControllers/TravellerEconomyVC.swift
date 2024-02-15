//
//  TravellerEconomyVC.swift
//  AirportProject
//
//  Created by Codebele 09 on 26/06/22.
//

import UIKit
import CoreData

class TravellerEconomyVC: BaseTableVC {
    
    @IBOutlet weak var dismissalView: UIView!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var tableRow = [TableRow]()
    var count = 1
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var infantsCount = 0
    var roomCountArray = [Int]()
    static var newInstance: TravellerEconomyVC? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? TravellerEconomyVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
            if selectedTab == "Flights" {
                
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    }else if journeyType == "circle" {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    }else {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0") ?? 0
                    }
                }
                
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        dismissalView.layer.cornerRadius = dismissalView.layer.frame.width / 2
        holderView.backgroundColor = .white
        holderView.layer.cornerRadius = 20
        holderView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        holderView.clipsToBounds = true
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        commonTableView.registerTVCells(["RadioButtonTVCell",
                                         "TravellerEconomyTVCell",
                                         "TitleLblTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "CommonTVCell",
                                         "checkOptionsTVCell"])
        
        setupSearchFlightEconomyTVCells()
        
        
    }
    
    func setupSearchFlightEconomyTVCells(){
        
        tableRow.removeAll()
    
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                tableRow.append(TableRow(title:"Adult",subTitle: "12+",text: "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"child",subTitle: "2-11",text: "\(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "0-2",text: "\(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            } else if journeyType == "circle" {
                tableRow.append(TableRow(title:"Adult",subTitle: "12+",text: "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"child",subTitle: "2-11",text: "\(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "0-2",text: "\(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            } else {
                tableRow.append(TableRow(title:"Adult",subTitle: "12+",text: "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"child",subTitle: "2-11",text: "\(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0")",cellType:.TravellerEconomyTVCell))
                tableRow.append(TableRow(title:"Infant",subTitle: "0-2",text: "\(defaults.string(forKey: UserDefaultsKeys.infantsCount) ?? "0")",cellType:.TravellerEconomyTVCell))
            }
        }
        
        tableRow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Class",key: "Class",cellType:.TitleLblTVCell))
        tableRow.append(TableRow(cellType: .CommonTVCell))
        
        tableRow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tableRow.append(TableRow(title:"Done",key: "bhuran",cellType:.ButtonTVCell))
        tableRow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    @IBAction func BackButtonAction(_ sender: Any) {
        gotoBackScreen()
    }
    
    @objc func gotoBackScreen() {
        self.dismiss(animated: true)
    }
    
    override func didTapOnIncrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Increment the infant count if it's less than the number of adults
            if infantsCount < adultsCount {
                infantsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
            
            
        } else if cell.titlelbl.text == "Adult" {
            // Increment adults, but don't exceed 9 travelers in total
            if (adultsCount + childCount) < 9 {
                adultsCount += 1
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else {
            if (adultsCount + childCount) < 9 {
                // Increment children, but don't exceed 9 travelers in total
                if cell.count >= 0 {
                    cell.count += 1
                    cell.countlbl.text = "\(cell.count)"
                }
                if cell.titlelbl.text == "child" {
                    childCount = cell.count
                }
            }
        }
        
        updateTotalTravelerCount()
    }
    
    override func didTapOnDecrementButton(cell: TravellerEconomyTVCell) {
        if cell.titlelbl.text == "Infant" {
            // Decrement the infant count if it's greater than 0
            if infantsCount > 0 {
                infantsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
        } else if cell.titlelbl.text == "Adult" {
            // Decrement adults, but don't go below 1
            if adultsCount > 1 {
                adultsCount -= 1
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
                
                
                
                // Set child count to 0
                if let infantCell = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? TravellerEconomyTVCell {
                    infantCell.count = 0
                    infantCell.countlbl.text = "\(infantCell.count)"
                    infantsCount = 0
                }
                
            }
            
        } else {
            // Decrement children
            if cell.count > 0 {
                cell.count -= 1
                cell.countlbl.text = "\(cell.count)"
            }
            if cell.titlelbl.text == "child" {
                childCount = cell.count
            }
        }
        
        updateTotalTravelerCount()
    }
    
    
    
    
    func updateTotalTravelerCount() {
        let totalTravelers = adultsCount + childCount + infantsCount
        print("Total Count === \(totalTravelers)")
        defaults.set(totalTravelers, forKey: UserDefaultsKeys.totalTravellerCount)
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppGreenColor)
            
            
            if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journeyType == "oneway" {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)
                }else if journeyType == "circle" {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)
                }else {
                    defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.selectClass)
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RadioButtonTVCell {
            cell.radioImg.image = UIImage(named: "radioUnselected")
        }
    }
    
    func gotoBookFlightVC() {
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                
                
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
                
                
            }else if journeyType == "circle" {
                
                
                let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
                defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.travellerDetails)
                
                
            }else{
                
                let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1") Traveller - \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
                defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.travellerDetails)
                
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("calreloadTV"), object: nil)
        self.dismiss(animated: true)
    }
    
    func gotoSearchHotelsVC() {
//                guard let vc = SearchHotelsVC.newInstance.self else {return}
//                vc.modalPresentationStyle = .overCurrentContextad
//                self.present(vc, animated: false)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("infantsCount \(infantsCount)")
        if cell.titlelbl.text == "Done" {
            if let selectedTab = defaults.string(forKey: UserDefaultsKeys.dashboardTapSelected){
                if selectedTab == "Flights" {
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if journeyType == "oneway" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                        }else if journeyType == "circle" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                        }else {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                            defaults.set(infantsCount, forKey: UserDefaultsKeys.infantsCount)
                        }
                    }
                    
                    gotoBookFlightVC()
                }
            }
        }
    }
    
}


