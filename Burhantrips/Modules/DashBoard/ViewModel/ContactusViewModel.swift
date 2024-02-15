//
//  ContactusViewModel.swift
//  KuwaitWays
//
//  Created by FCI on 21/12/23.
//

import Foundation
import Foundation


protocol ContactusViewModelDelegate : BaseViewModelProtocol {
    func contactusResponse(response : NewContactusModel)
}

class ContactusViewModel {
    
    var view: ContactusViewModelDelegate!
    init(_ view: ContactusViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_CONTACT_US_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.general_mobile_contact_us, parameters: parms, resultType: NewContactusModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.contactusResponse(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
}
