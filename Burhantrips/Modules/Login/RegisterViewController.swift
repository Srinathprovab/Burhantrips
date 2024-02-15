//
//  RegisterViewController.swift
//  Travrun
//
//  Created by MA1882 on 05/12/23.
//

import UIKit
import DropDown

struct RegistrationModel {
    var firstName: String?
    var lastName: String?
    var mobileNumber: String?
    var emailAddress: String?
    var password: String?
    var confirmPassword: String?
}


class RegisterViewController: UIViewController, UITextFieldDelegate, RegisterViewModelProtocal  {
   
    @IBOutlet weak var countryCodeView: BorderedView!
    @IBOutlet weak var backButtonView: UIView!
    @IBOutlet weak var eyeImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var phoneNumerTextField: UITextField!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var regButton: UIButton!
    @IBOutlet weak var passwodTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    static var newInstance: RegisterViewController? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? RegisterViewController
        return vc
    }
    
    let dropDown = DropDown()
    var tablerow = [TableRow]()
    var loginKey = "login"
    var fname = ""
    var lname = ""
    var email = ""
    var mobile = ""
    var countryCode = ""
    var pass = ""
    var cpass = ""
    var showPwdBool = true
    var payload = [String:Any]()
    var regViewModel: RegisterViewModel?
    var uname = String()
    var password = String()
    var isVcFrom = String()
    var countryNameArray = [All_country_code_list]()
    var searchText = String()
    var isSearchBool = Bool()
    var countryNames = [String]()
    var countrycodesArray = [String]()
    var isocountrycodeArray = [String]()
    var originArray = [String]()
    var isoCountryCode = String()
    var billingCountryName = String()
    var nationalityCode = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        regViewModel = RegisterViewModel(self)
        setiupUI()
        loadCountryNamesAndCode()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    func setiupUI()  {
        countryNameArray = countrylist
        setupDropDown()
        phoneNumerTextField.layer.cornerRadius = 4
        passwodTextField.isSecureTextEntry = true
        backButtonView.layer.cornerRadius = backButtonView.layer.frame.width / 2
        passwodTextField.placeholder = "Enter Password"
        emailTextField.placeholder = "Enter Email Id"
        phoneNumerTextField.placeholder = "Enter Phone Number"
        countryCodeTextField.placeholder = "+91"
        countryCodeTextField.setLeftPaddingPoints(16)
        passwodTextField.setLeftPaddingPoints(16)
        emailTextField.setLeftPaddingPoints(16)
        phoneNumerTextField.setLeftPaddingPoints(16)
        passwodTextField.layer.cornerRadius = 4
        passwodTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        passwodTextField.layer.borderWidth =  0.7
        emailTextField.layer.borderWidth =  0.7
        phoneNumerTextField.layer.borderWidth =  0.7
        phoneNumerTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        emailTextField.layer.borderColor = HexColor("#CCCCCC").cgColor
        emailTextField.layer.cornerRadius = 4
        regButton.layer.cornerRadius = 4
        emailTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        passwodTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        phoneNumerTextField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        countryCodeTextField.addTarget(self, action: #selector(searchTextChanged(textField:)), for: .editingChanged)
        countryCodeTextField.addTarget(self, action: #selector(searchTextBegin(textField:)), for: .editingDidBegin)
        eyeImage.image = UIImage(named: "eyeslash")
    }
    
    func setupDropDown() {
        dropDown.direction = .bottom
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.countryCodeView
        dropDown.bottomOffset = CGPoint(x: 0, y: countryCodeView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countryCodeTextField.text = self?.countrycodesArray[index]
            self?.isoCountryCode = self?.isocountrycodeArray[index] ?? ""
            self?.billingCountryName = self?.countryNames[index] ?? ""
            self?.nationalityCode = self?.originArray[index] ?? ""
            self?.countryCodeTextField.text = self?.countrycodesArray[index] ?? ""
            paymobilecountrycode = self?.countrycodesArray[index] ?? ""
            self?.countryCodeTextField.resignFirstResponder()
//            self?.phoneNumerTextField.text = ""
//            self?.phoneNumerTextField.becomeFirstResponder()
        }
    }
    
    
    @objc func editingText(textField:UITextField) {
        uname = emailTextField.text ?? ""
        password = passwodTextField.text ?? ""
        self.countryCode = self.countryCodeTextField.text ?? ""
    }
    
    
    @objc func searchTextBegin(textField: UITextField) {
        textField.text = ""
        countryNameArray.removeAll()
        countryNameArray = countrylist
        loadCountryNamesAndCode()
        dropDown.show()
    }
    
    
    @objc func searchTextChanged(textField: UITextField) {
        searchText = textField.text ?? ""
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
        }
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        
        countryNameArray.removeAll()
        countryNameArray = countrylist.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        loadCountryNamesAndCode()
        dropDown.show()
        
    }
    
    func loadCountryNamesAndCode(){
        countryNames.removeAll()
        countrycodesArray.removeAll()
        isocountrycodeArray.removeAll()
        originArray.removeAll()
        
        countryNameArray.forEach { i in
            countryNames.append(i.name ?? "")
            countrycodesArray.append(i.country_code ?? "")
            isocountrycodeArray.append(i.iso_country_code ?? "")
            originArray.append(i.origin ?? "")
        }
        
        DispatchQueue.main.async {[self] in
            dropDown.dataSource = countryNames
        }
    }
    
    @IBAction func countryCodeBtnAction(_ sender: Any) {
//        dropDown.show()
    }
    @IBAction func eyeBtnAction(_ sender: Any) {
        if showPwdBool == true {
            eyeImage.image = UIImage(named: "showpass")?.withTintColor(.black)
            passwodTextField.isSecureTextEntry = false
            showPwdBool = false
        }else {
            passwodTextField.isSecureTextEntry = true
            eyeImage.image = UIImage(named: "eyeslash")
            showPwdBool = true
        }
        
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        callRegisterAPI()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
//        guard let vc = LoginViewController.newInstance.self else {return}
//       vc.modalPresentationStyle = .fullScreen
//       present(vc, animated: true)
        dismiss(animated: true)
    }
    
    @IBAction func backButtonAtion(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func callRegisterAPI() {
        mobile = phoneNumerTextField.text ?? ""
        email = emailTextField.text ?? ""
        pass = passwodTextField.text ?? ""
        
        if email == "" {
            showToast(message: "Enter Email Adress")
        } else if email.isValidEmail() == false {
            showToast(message: "Enter the Valid Email Address")
        } else if mobile == "" {
            showToast(message: "Enter Phone Number")
        } else if mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Phone No")
        } else if countryCode == "" {
            showToast(message: "Enter country code")
        } else if pass == "" {
            showToast(message: "Enter Password")
        } else {
            payload["first_name"] = fname
            payload["last_name"] = lname
            payload["email"] = email
            payload["password"] = pass
            payload["phone"] = mobile
            payload["country_code"] = countryCode
            regViewModel?.CallRegisterAPI(dictParam: payload)
        }
    }
    
    func RegisterDetails(response: RegisterModel) {
        print(response)
        if response.status == false {
            showToast(message: response.msg ?? "")
        } else {
            showToast(message: "Register Sucess")
            defaults.set(response.data?.user_id, forKey: UserDefaultsKeys.userid)
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                if isVcFrom == "BookingDetailsVC" {
                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                    self.dismiss(animated: true)
                }else {
                    gotoHomeScreen()
                }
            }
        }
    }
    

    func gotoHomeScreen() {
        guard let vc = DashBoardTabBarViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
    
    func loginDetails(response: LoginModel) {}
}

extension RegisterViewController {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}

