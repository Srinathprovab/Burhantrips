//
//  DashBoardTabBarViewController.swift
//  Travrun
//
//  Created by Mahesh on 09/11/23.
//

import UIKit

class DashBoardTabBarViewController: UITabBarController {
    
    static var newInstance: DashBoardTabBarViewController? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? DashBoardTabBarViewController
        return vc
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func setTabBarItems(){

        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().tintColor = .AppLabelColor
        UITabBar.appearance().unselectedItemTintColor = HexColor("#9CC1D8")

        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "homeIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#9CC1D8"))
        myTabBarItem1.selectedImage = UIImage(named: "homeIcon")
        myTabBarItem1.title = "Home"
        myTabBarItem1.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)

        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        
        myTabBarItem2.image = UIImage(named: "tripsIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "tripsIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#EE1935"))
        myTabBarItem2.title = "Trips"
        myTabBarItem2.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)

        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = UIImage(named: "profileIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "profileIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#EE1935"))
        myTabBarItem3.title = "Profile"
        myTabBarItem3.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)

        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "moreIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "moreIcon")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(HexColor("#EE1935"))
        myTabBarItem4.title = "More"
        myTabBarItem4.imageInsets = UIEdgeInsets(top: -3, left: 0, bottom: -6, right: 0)
    }
}
