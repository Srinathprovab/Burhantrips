//
//  ProcessingViewController.swift
//  Travrun
//
//  Created by MA1882 on 28/11/23.
//

import UIKit

class ProcessingViewController: UIViewController {
    @IBOutlet weak var borderView: BorderedView!
    
    static var newInstance: ProcessingViewController? {
        let storyboard = UIStoryboard(name: Storyboard.FlightStoryBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ProcessingViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        showLoaderhere()
        // Do any additional setup after loading the view.
    }
    
    
//    func showLoaderhere() {
//        self.view.isUserInteractionEnabled = false
//        Loader.showAdded(to: self.borderView, animated: true)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
