//
//  HotelBookingDetailsViewModel.swift
//  Travrun
//
//  Created by MA1882 on 29/12/23.
//

enum HotelBookingRows {
    case login
    case guestLogin
    case register
}

protocol HotelBookingDetailsOutput {
    var dataArray: [passInfo] { get set }
    var isDropOpen: Bool { get set }
    var section: Rows? { get set }
}

class HotelBookingDetailsViewModel: MBInfoOutput {
    var section: Rows? = .guestLogin
    var isDropOpen: Bool = false
    var dataArray: [passInfo] = [.init(isOpen: false)]
    var view: MBViewModelDelegate!
    init(_ view: MBViewModelDelegate) {
        self.view = view
    }
}
