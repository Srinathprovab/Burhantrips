//
//  Constants.swift
//  AppStructureDemo
//
//  Created by U Dinesh Kumar Reddy on 09/03/22.
//

import Foundation
import UIKit


var dateSelectKey = ""
let defaults = UserDefaults.standard
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/json"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
let KDEVICE_ID = "DEVICE_ID"
var KAccesstoken = "Accesstoken"
var loderBool = false
//let tempAccessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.IjQ5MyI.lZlN_1oQldjp7DX7Cah05igwkYhgiYqmru-JNqvAX60"
var tempAccessToken = "cpk5sre43kpsprytujhjatquwevgtpljkg?e21nfo5k#qaqwe6thnbde"
//http://dev.irepo.in:8080/        POST API Base url
//https://staging.doorcast.tech/     GET API url
//var BASE_URL = "https://staging.doorcast.tech/"
//let signInApi = "DQI-api/signin"
let getApiEndPoint = "api/get_organizations"
var BASE_URL1 = "https://provabdevelopment.com/burhan_trips/pro_new/mobile/index.php/"
var BASE_URL = "https://provabdevelopment.com/burhan_trips/pro_new/mobile/index.php/"

let signInApi = "signin"
let homeApi = "events_details"

struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


let KAevent_status = "event_status"
let KAevent_type = "event_type"
let KAevent_view = "event_view"
let KAeventId = "eventId"
let KApage = "page"
let KAuserId = "userId"
var countrycode = String()
var paymobilecountrycode = String()
var mbSummery = [Summary]()
var addon_services = [Addon_services]()
var priceDetailsArry: [MBPriceDetails]?
var whatsAppPrice = String()
var flexiblePrie = String()
var priceChange = String()
var notificationPrice = String()
var whatsAppCheck = true
var priceCheck = true
var flexibleCheck = true
var notificationCheck = true
var addonCheck = true
var frequent_flyersArray = [Frequent_flyers]()
var countrylist = [All_country_code_list]()
var cityList:[SelectCityModel] = []
var depatureDatesArray = ["Date","Date"]
var KAevent_statusValue = ""
var KAevent_typeValue = ""
var KAevent_viewValue = ""
var KAeventIdValue = ""
var KApageValue = ""
var KAuserIdValue = ""
var KAccesstokenValue = ""
var KAUserAccessTokenValue = ""
var callapibool = Bool()
var faretypeArray = [String]()
var AirlinesArray = [String]()
var ConnectingFlightsArray = [String]()
var ConnectingAirportsArray = [String]()
var luggageArray = [String]()
var prices = [String]()
var MCJflightlist :[[MCJ_flight_list]]?
var FlightList :[[J_flight_list]]?
var topHotelDetails = [TopHotelDetails]()
var rating = String()
var topFlightDetails = [TopFlightDetails]()
var deailcodelist = [Deail_code_list]()
var topHolidayList = [city_data_list]()
var fd = [[FDFlightDetails]]()
var jd = [JourneySummary]()
var fareRulehtml = [FareRulehtml]()

var keyStr = String()
var isBtnHidden = true
var directFlightBool = true
var oldjournyType = ""
var checkTermsAndCondationStatus = false

//MARK: - Multicity
var fromCityNameArray = ["From","From"]
var fromCityCodeArray = ["From","From"]
var fromlocidArray = ["",""]
var toCityNameArray = ["To","To"]
var toCityCodeArray = ["To","To"]
var tolocidArray = ["",""]
var fromCityShortNameArray = ["From","From"]
var toCityShortNameArray = ["To","To"]
var finalInputArray = [[String:Any]]()



//Register
var registrationModel:RegistrationModel?


// Screen width.
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

var thefareRules: CustomFarerules?
var fareCurrencyType = String()
var tripCurrencyType = String()
var totalprice = String()
var Adults_Base_Price = String()
var Adults_Tax_Price = String()
var Childs_Base_Price = String()
var Childs_Tax_Price = String()
var Infants_Base_Price = String()
var Infants_Tax_Price = String()
var TotalPrice_API = String()
var grandTotal = String()
var subtotal = String()

var AdultsTotalPrice = String()
var ChildTotalPrice = String()
var InfantTotalPrice = String()
var sub_total_adult : String?
var sub_total_child : String?
var sub_total_infant : String?
var isChecked =  true
var totalRooms = 0
var totalAdults = 0
var totalChildren = 0

//MARK: - Profile details
var pdetails:ProfileDetails?

//MARK: - Travellers Details
//var adultTravllersArray = [TravellerData]()
//var childTravllersArray = [TravellerData]()
//var infantaTravllersArray = [TravellerData]()
var checkOptionCountArray = [String]()
var passengertypeArray = [String]()
var genderArray = [String]()
var leadPassengerArray = [String]()
var middleNameArray = [String]()
var arrayOf_SelectedCellsAdult = [IndexPath]()
var arrayOf_SelectedCellsChild = [IndexPath]()
var arrayOf_SelectedCellsInfanta = [IndexPath]()
var totalNoOfTravellers = String()
var cityLocId:[String] = []
var hotelSearchResult = [HotelSearchResult]()
//var passengerA = [Passenger]()
//var travelerArray: [Traveler] = []
//var ageCategory: AgeCategory = .adult
var latArray = [String]()
var longArray = [String]()
var passportExpireDateBool = false
var mapModelArray: [MapModel] = []
var travelerArray: [Traveler] = []
var hotelSearchId = String()
var MBfd :[[MBdetails]]?
var mobilenoMaxLengthBool = false
var ageCategory: AgeCategory = .adult

//MARK: - FILTER RELATED VARIABLES
var filterTap = String()
var filterPrice = String()
var filterModel = FlightFilterModel()
var sortBy: SortParameter = .nothing
var hotelfiltermodel = HotelFilterModel()

//Flight Paynow Screen
var payemail = String()
var paymobile = String()

//var mapModelArray: [MapModel] = []



//MARK: - Baggage Info details
var farerulerefkey = String()
var farerulesrefcontent = String()
var fdbool = true


//MARK: - Hotel
//var hotelSearchId = String()
//var roomsDetails = [[Rooms]]()
//var images = [Images]()
//var formatAmeArray = [Format_ame]()
//var formatDesc = [Format_desc]()
var hotel_filtersumry : Filter_sumry?
var hsearchid = String()
var hbookingsource = String()
var htoken = String()
var htokenkey = String()
var selectedrRateKeyArray = [String]()

var adtArray = [String]()
var chArray = [String]()
//var callapibool = Bool()
var hotelDetailsTapBool = true

var neighbourwoodArray = [String]()
var amenitiesArray = [String]()
var nearBylocationsArray = [String]()

var selectedCellIndices: [IndexPath] = [] // Keep track of selected cell indices
var selectedCellStates: [IndexPath: Bool] = [:]
var bookedDate = String()
var pnrNo = String()
var bookingRefrence = String()
var bookingId = String()
var flightSelectedIndex = Int()
//var prebookingcancellationpolicy : Pre_booking_cancellation_policy?
var userspecification = [String]()


//MARK: - HOME SCREEN

struct UserDefaultsKeys {
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mfromcityname = "mfromcityname"
    static var mtocityname = "mtocityname"
    
    static var rselect_classIndex = "rselect_classIndex"
    static var travellerTitle = "travellerTitle"
    static var totalTravellerCount = "totalTravellerCount"
    static var journeyTypeSelectedIndex = "Journey_TypeSelectedIndex"
    static var DashboardTapSelectedCellIndex = "DashboardTapSelectedCellIndex"
    static var mobilecountrycode = "mobilecountrycode"
    static var isSelected = false
    static var gender = "gender"
    static var rinfantsCount = "rInfants_Count"
    static var rchildCount = "rChild_Count"
    static var radultCount = "rAdult_Count"
    static var useremail = "useremail"
    static var usermobile = "usermobile"
    static var uname = "uname"
    static var mcountrycode = "mcountrycode"
    static var userid = "userid"
    static var countryCode = "countryCode"
    static var toairport = "toairport"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var rcalRetDate = "rcalRetDate"
    static var icalDepDate = "icalDepDate"
    static var ircalDepDate = "ircalDepDate"
    static var frcalDepDate = "frcalDepDate"
    static var frcalRetDate = "frcalRetDate"
    static var ircalRetDate = "ircalRetDate"
    static var mcaldate = "mcaldate"
    static var InsurenceJourneyType = "Insurence_Journey_Type"
    static var cellTag = "cellTag"
    static var rcalDepDate = "rcalDepDate"
    static var calDepDate = "calDepDate"
    static var journeyType = "Journey_Type"
    static var selectedCurrency = "selectedCurrency"
    static var loggedInStatus = "loggedInStatus"
    static var APICurrencyType = "APICurrencyType"
    static var APILanguageType = "APILanguageType"
    static var searchid = "search_id"
    static var selectedResult = "selectedResult"
    static var bookingsourcekey = "booking_source_key"
    static var traceId = "traceId"
    
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var fromcityCode = "fromcityCode"
    static var toCityCode = "toCityCode"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var totalTravller = "totalTravller"
    static var childCount = "Child_Count"
    static var infantsCount = "Infants_Count"
    static var selectClass = "select_class"
    static var select_classIndex = "select_classIndex"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var fromairport = "fromairport"
    static var fromcityname = "fromcityname"
    static var tocityname = "tocityname"
    static var tairportCode = "tairportCode"
    static var travellerDetails = "travellerDetails"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var dashboardTapSelected = "DashboardTapSelected"
    static var rtravellerDetails = "rtravellerDetails"
    static var rselectClass = "rselect_class"
    static var bookingsource = "booking_source"
    static var selectedFareType = "fare_type"
    
    // Hotel
    
    static var locationcity = "location_city"
    static var locationcityid = "location_cityid"
    static var locationcityname = "locationcityname"
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectPersons = "selectPersons"
    
    
}


struct sessionMgrDefaults {
    static var loggedInStatus = "email"
}

struct ApiEndpoints {
    static let general_mobile_contact_us = "general/contactus"
    static let general_mobileHotelSearch = "general/mobileHotelSearch"
    static let ajaxHotelSearch_pagination = "ajaxHotelSearch_pagination"
    static let mobileprehotelsearch = "mobile_pre_hotel_search"
    static let general_getActiveBookingSource = "general/getActiveBookingSource"
    static let gethotelcitylist = "ajax/get_hotel_city_list"
    static let getFlightDetails = "getFlightDetails"
    static let getBaggageFlightDetails = "getFlightDetails"
    static let mobileUpdateTraveller = "mobileUpdateTraveller"
    static let mobileInsertTraveller = "mobileInsertTraveller"
    static let mobilepreprocessbooking = "mobile_pre_process_booking"
    static let mobileprocesspassengerdetail = "mobile_process_passenger_detail"
    static let mobileShowTraveller = "mobileShowTraveller"
    static let mobileTravellerDetailsByOrigin = "mobileTravellerDetailsByOrigin"
    static let register = "mobile_register_on_light_box"
    static let mobileforgotpassword = "mobile_forgot_password"
    static let login = "mobile_login"
    static let mobilelogout = "mobile_ajax_logout"
    static let mobileprofile = "mobile_profile"
    static let getTopFlightHotelDestination = "getTopFlightHotelDestination"
    static let getCountryList = "getCountryList"
    static let getairportcodelistmulticity = "get_airport_code_list_ios"
    static let currencylist = "currency_list"
    static let mobilePreFlightSearch = "mobile_pre_flight_search"
    static let getairportcodelist = "get_airport_code_list"
    static let mobileDeleteTraveller = "mobileDeleteTraveller"
    static let getfarerules = "get_fare_rules"
    static let completedbookingmobile = "completed_booking_mobile"
    static let upcomingbookingmobile = "upcoming_booking_mobile"
    static let cancelledbookingmobile = "cancelled_booking_mobile"
    static let contactus = "contactus"
}
