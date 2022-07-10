//
//  HolidayRequest.swift
//  HolidayCalendar
//
//  Created by Emanuel on 29/06/2022.
//

import Foundation

// configuro a que quiero acceder

enum HolidayError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct HolidayRequest {
    let resourceURL: URL
    let APIKey = "2dfd5968b44ef7851b5e9b8b4c51c59fa4ca3636"
    
    init(countryCode: String) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourceString = "https://calendarific.com/api/v2/holidays?api_key=\(APIKey)&country=\(countryCode)&year=\(currentYear)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    func getHolidays (completion: @escaping(Result<[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            // if we have json data
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidaysDetails = holidaysResponse.response.holidays
                completion(.success(holidaysDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
