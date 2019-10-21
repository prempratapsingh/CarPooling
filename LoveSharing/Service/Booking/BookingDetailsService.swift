//
//  BookingDetailsService.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

class BookingDetailsService {
    
    func getBookingDetails(completionHandler: @escaping BookingDetailsCompletionHandler) {
        if let path = Bundle.main.path(forResource: "next_booking", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                let booking = try jsonDecoder.decode(Booking.self, from: data)
                completionHandler(booking, nil)
            } catch {
               let error = "Oops! Something went wrong. Couldn't load the booking details, please try again later!"
                completionHandler(nil, error)
            }
        } else {
            let error = "Oops! Something went wrong. Couldn't load the booking details, please try again later!"
            completionHandler(nil, error)
        }
    }
}
