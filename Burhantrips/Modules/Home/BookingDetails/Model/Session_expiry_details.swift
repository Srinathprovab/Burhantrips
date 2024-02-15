
import Foundation
struct Session_expiry_details : Codable {
	let session_start_time : Int?
	let search_hash : String?

	enum CodingKeys: String, CodingKey {

		case session_start_time = "session_start_time"
		case search_hash = "search_hash"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		session_start_time = try values.decodeIfPresent(Int.self, forKey: .session_start_time)
		search_hash = try values.decodeIfPresent(String.self, forKey: .search_hash)
	}

}


struct Addon_services : Codable {
    let origin : String?
    let title : String?
    let display_title : String?
    let details : String?
    let original_price : String?
    let price : String?
    let stype : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        case origin = "origin"
        case title = "title"
        case display_title = "display_title"
        case details = "details"
        case original_price = "original_price"
        case price = "price"
        case stype = "stype"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        display_title = try values.decodeIfPresent(String.self, forKey: .display_title)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        original_price = try values.decodeIfPresent(String.self, forKey: .original_price)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        stype = try values.decodeIfPresent(String.self, forKey: .stype)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
}
