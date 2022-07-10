//
//  HolidayModel.swift
//  HolidayCalendar
//
//  Created by Emanuel on 29/06/2022.
//

import Foundation
// las structs mapean el JSON, adoptar este tipo de estructuras a todas las APIS

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable {
    var iso: String
}

