//
//  ContactUsVC.swift
//  BabSafar
//
//  Created by FCI on 18/02/23.
//

import UIKit
import MessageUI

class ContactUsVC: BaseTableVC, ContactusViewModelDelegate {
    
    
    @IBOutlet weak var backButtonView: UIView!
    static var newInstance: ContactUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.DashBoard.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContactUsVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var name = String()
    var email = String()
    var mobil = String()
    var message = String()
    var payload = [String:Any]()
    var vm: ContactusViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = ContactusViewModel(self)
    }
    
    func setupUI() {
        commonTableView.registerTVCells(["ContactUsTVCell", "EmptyTVCell"])
        setupTVCells()
    }
    
    
    func setupTVCells() {
        backButtonView.layer.cornerRadius =  backButtonView.layer.frame.width / 2
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.ContactUsTVCell))
        tablerow.append(TableRow(height: 50, cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func textViewDidChange(textView:UITextView){
        message = textView.text
    }
    
    override func editingTextField(tf:UITextField){
        switch tf.tag {
        case 1:
            name = tf.text ?? ""
            break
            
        case 2:
            email = tf.text ?? ""
            break
            
        case 3:
            mobil = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    override func didTapOnMailBtnAction(cell: ContactUsTVCell) {
        openEmail(mailstr: "reservation@kuwaitways.com")
    }
    
    override func didTapOnPhoneBtnAction(cell: ContactUsTVCell) {
        let phoneNumber = "+965 22092007" // Replace with the actual phone number from your data
        makePhoneCall(number: phoneNumber)
    }
    
    override func didTapOnSubmitBtnAction(cell: ContactUsTVCell) {
        
        if name.isEmpty == true {
            showToast(message: "Enter Full Name")
        }else if email.isEmpty == true {
            showToast(message: "Enter Email")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email")
        }else if mobil.isEmpty == true {
            showToast(message: "Mobile Number")
        }else {
            callAPI()
        }
    }
    
    
    @IBAction func didTapOnBackBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}



extension ContactUsVC {
    
    func callAPI() {
        
        payload.removeAll()
        payload["full_name"] = name
        payload["email"] = email
        payload["phone_number"] = mobil
        payload["message"] = message
        payload["country_code"] = "+91"
        
        vm?.CALL_CONTACT_US_API(dictParam: payload)
    }
    
    func contactusResponse(response: NewContactusModel) {
        if response.status == 1 {
            showToast(message: response.msg ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                dismiss(animated: true)
            }
        }
    }
    
}



extension ContactUsVC:MFMailComposeViewControllerDelegate {
    
    @objc func openEmail(mailstr:String) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([mailstr]) // Set the recipient email address
            
            // Set the email subject
            //    composeVC.setSubject("Hello from Swift!")
            
            // Set the email body
            //   composeVC.setMessageBody("This is the body of the email.", isHTML: false)
            
            present(composeVC, animated: true, completion: nil)
        } else {
            // Handle the case when the device cannot send emails
            print("Device cannot send emails.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    func makePhoneCall(number: String) {
        
        if let phoneURL = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            // Handle the case where the device cannot make calls or the URL is invalid.
        }
    }
    
    
}
