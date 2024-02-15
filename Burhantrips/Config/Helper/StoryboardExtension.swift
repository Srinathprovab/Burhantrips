//
//  StoryboardExtension.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit


enum Storyboard: String {
    case Main
    case DashBoard
    case Login
    case Visa
    case Insurance
    case SearchHotel
    case Calender
    case PaymentGateway
    case FastTrack
    case FlightStoryBoard
    case Filter
    case BookingDetails
    
    var name: String {
        return self.rawValue.capitalizingFirstLetter()
    }
}

extension UIViewController {
    static var storyboardId: String {
        return self.className()
    }
}
