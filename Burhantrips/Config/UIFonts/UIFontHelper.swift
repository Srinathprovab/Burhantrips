//
//  UIFontHelper.swift
//  Example-Projects
//
//  Created by Codebele 05 on 03/02/20.
//  Copyright © 2020 Codebele 05. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    
    //MARK:- shifu app
    
    
    public static func InterSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func InterMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func InterBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func InterExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }


    public static func latoBlack(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Black", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func PoppinsSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func PoppinsMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    
    public static func PoppinsBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func PoppinsExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func PoppinsBlack(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Black", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func PoppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func latoSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "latosemibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    public static func latoMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "latomedium", size: size) ?? UIFont.systemFont(ofSize: size)
    }


    public static func latoBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    public static func latoThin(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
    }


    public static func latoRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "latoregular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    public static func InterRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    //Custom fonts
    
    public static var titleLabelFont: UIFont {
        get {
            return UIFont.InterBold(size: 15)
        }
    }
    
    public static var errorLabelFont: UIFont {
        get {
            return UIFont.InterMedium(size: 15)
        }
    }
    
    public static var textFieldFont: UIFont {
        get {
            return UIFont.InterSemiBold(size: 20)
        }
    }
    
    
    public static var buttonTitleFont: UIFont {
        get {
            return UIFont.InterExtraBold(size: 22)
        }
    }
    
}



extension UIColor {
    
    
    //Custom Colors
    
    public static var holderViewColor: UIColor? {
        get {
            return UIColor.white
        }
    }
    
    
    public static var titleLabelColor: UIColor? {
        get {
            return UIColor.black
        }
    }
    
    
    
    public static var errorLabelColor: UIColor? {
        get {
            return UIColor.red.withAlphaComponent(0.6)
        }
    }
    
    
    public static var viewBorderColor: UIColor? {
        get {
            return UIColor.gray.withAlphaComponent(0.5)
        }
    }
    
    public static var textFieldColor: UIColor? {
        get {
            return UIColor.black
        }
    }
    
    
    public static var bottomLineColor: UIColor? {
        get {
            return UIColor.black.withAlphaComponent(0.3)
        }
    }
    
    
    public static var buttonBGColor: UIColor? {
        get {
            return UIColor.blue.withAlphaComponent(0.7)
        }
    }
    
    
    public static var buttonTitleColor: UIColor? {
        get {
            return UIColor.white
        }
    }
    
    public static var ImageUnSelectColor : UIColor {
        get {
            return UIColor(named: "ImageUnSelectColor")!
        }
    }
    
    
    
    
    func Hexacolor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



func HexColor(_ hex:String , alpha:CGFloat = 1.0) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
