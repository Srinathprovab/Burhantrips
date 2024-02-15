//
//  ContactUsTVCell.swift
//  KuwaitWays
//
//  Created by FCI on 20/12/23.
//

import UIKit
import MaterialComponents

protocol ContactUsTVCellDelegate {
    func editingTextField(tf:UITextField)
    func didTapOnAddressBtnAction(cell:ContactUsTVCell)
    func didTapOnMailBtnAction(cell:ContactUsTVCell)
    func didTapOnPhoneBtnAction(cell:ContactUsTVCell)
    func didTapOnSubmitBtnAction(cell:ContactUsTVCell)
    func textViewDidChange(textView:UITextView)
}

class ContactUsTVCell: TableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var nameTF: MDCOutlinedTextField!
    @IBOutlet weak var emailTF: MDCOutlinedTextField!
    @IBOutlet weak var mobileTF: MDCOutlinedTextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    var placeHolder = String()
    var delegate:ContactUsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func setupUI() {
        
        
        setupTextField(txtField1: nameTF,
                       tagno: 1,
                       placeholder: "Name",
                       title: "Enter Name",
                       subTitle: "Name")
        
        setupTextField(txtField1: emailTF,
                       tagno: 2,
                       placeholder: "Email",
                       title: "Enter Email",
                       subTitle: "Email")
        
        
        setupTextField(txtField1: mobileTF,
                       tagno: 3,
                       placeholder: "Mobile Number",
                       title: "Enter Mobile Number",
                       subTitle: "Mobile Number")
        
        
        
        
        setupdescView()
    }
    
    
    
    func setupTextField(txtField1:MDCOutlinedTextField,tagno:Int,placeholder:String,title:String,subTitle:String){
        
        txtField1.tag = tagno
        txtField1.label.text = title
        // txtField1.text = subTitle
        txtField1.placeholder = placeholder
        txtField1.delegate = self
        txtField1.backgroundColor = .clear
        txtField1.font = UIFont.InterRegular(size: 16)
        txtField1.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        txtField1.label.textColor = .SubTitleColor
        txtField1.setOutlineColor( HexColor("#605F5F"), for: .editing)
        txtField1.setOutlineColor( .red , for: .disabled)
        txtField1.setOutlineColor( .lightGray.withAlphaComponent(0.4) , for: .normal)
        
        
    }
    
    
    func setupdescView() {
        
        messageTextView.layer.cornerRadius = 6
        messageTextView.clipsToBounds = true
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = UIColor.AppBorderColor.cgColor
        
        messageTextView.text = ""
        messageTextView.delegate = self
        messageTextView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 4)
        messageTextView.setPlaceholder(ph: placeHolder)
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
        delegate?.textViewDidChange(textView: textView)
    }
    
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
//    @IBAction func didTapOnAddressBtnAction(_ sender: Any) {
//        delegate?.didTapOnAddressBtnAction(cell: self)
//    }
//
    
    @IBAction func didTapOnSubmitBtnAction(_ sender: Any) {
        delegate?.didTapOnSubmitBtnAction(cell: self)
    }
    
    
    
    @IBAction func didTaponMailBtnAction(_ sender: Any) {
        delegate?.didTapOnMailBtnAction(cell: self)
    }
    
    
    @IBAction func didTapOnPhoneBtnAction(_ sender: Any) {
        delegate?.didTapOnPhoneBtnAction(cell: self)
    }
}


extension ContactUsTVCell {
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
            
            
        case 3://mobile
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        default:
            let maxLength = 50
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
    }
    
}

