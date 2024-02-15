//
//  FDPriceDetails.swift
//  BabSafar
//
//  Created by FCI on 18/11/22.
//

import Foundation

struct FDPriceDetails : Codable {
    let api_currency : String?
    let adultsBasePrice : String?
    let childBasePrice : String?
    let infantBasePrice : String?
    let adultsTaxPrice : String?
    let childTaxPrice : String?
    let infantTaxPrice : String?
    let adultsTotalPrice : String?
    let childTotalPrice : String?
    let infantTotalPrice : String?
    let sub_total_adult : String?
    let sub_total_child : String?
    let sub_total_infant : String?
    let grand_total : String?
    
    enum CodingKeys: String, CodingKey {
        
        case api_currency = "api_currency"
        case adultsBasePrice = "adultsBasePrice"
        case childBasePrice = "childBasePrice"
        case infantBasePrice = "infantBasePrice"
        case adultsTaxPrice = "adultsTaxPrice"
        case childTaxPrice = "childTaxPrice"
        case infantTaxPrice = "infantTaxPrice"
        case adultsTotalPrice = "adultsTotalPrice"
        case childTotalPrice = "childTotalPrice"
        case infantTotalPrice = "infantTotalPrice"
        case sub_total_adult = "sub_total_adult"
        case sub_total_child = "sub_total_child"
        case sub_total_infant = "sub_total_infant"
        case grand_total = "grand_total"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
        adultsBasePrice = try values.decodeIfPresent(String.self, forKey: .adultsBasePrice)
        childBasePrice = try values.decodeIfPresent(String.self, forKey: .childBasePrice)
        infantBasePrice = try values.decodeIfPresent(String.self, forKey: .infantBasePrice)
        adultsTaxPrice = try values.decodeIfPresent(String.self, forKey: .adultsTaxPrice)
        childTaxPrice = try values.decodeIfPresent(String.self, forKey: .childTaxPrice)
        infantTaxPrice = try values.decodeIfPresent(String.self, forKey: .infantTaxPrice)
        adultsTotalPrice = try values.decodeIfPresent(String.self, forKey: .adultsTotalPrice)
        childTotalPrice = try values.decodeIfPresent(String.self, forKey: .childTotalPrice)
        infantTotalPrice = try values.decodeIfPresent(String.self, forKey: .infantTotalPrice)
        sub_total_adult = try values.decodeIfPresent(String.self, forKey: .sub_total_adult)
        sub_total_child = try values.decodeIfPresent(String.self, forKey: .sub_total_child)
        sub_total_infant = try values.decodeIfPresent(String.self, forKey: .sub_total_infant)
        grand_total = try values.decodeIfPresent(String.self, forKey: .grand_total)
    }
    
}


struct CustomFarerules: Codable {
    let cancelation_fee: Fee?
    let date_charge_fee: Fee?
    let please_note: String?

    enum CodingKeys: String, CodingKey {
        case cancelation_fee = "cancelation_fee"
        case date_charge_fee = "date_charge_fee"
        case please_note = "please_note"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cancelation_fee = try values.decodeIfPresent(Fee.self, forKey: .cancelation_fee)
        date_charge_fee = try values.decodeIfPresent(Fee.self, forKey: .date_charge_fee)
        please_note = try values.decodeIfPresent(String.self, forKey: .please_note)
    }
    
    struct Fee: Codable {
        let text_bottom: String?
        let destination: String?
        let cancellation_title: String?
        let text_right: String?
        let text_left: String?
        let origin: String?

        enum CodingKeys: String, CodingKey {
            case text_bottom = "text_bottom"
            case destination = "destination"
            case cancellation_title = "cancellation_title"
            case text_right = "text_right"
            case text_left = "text_left"
            case origin = "origin"
        }
    }
}

