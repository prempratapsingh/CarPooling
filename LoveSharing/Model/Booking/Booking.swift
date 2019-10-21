//
//  Booking.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

class Booking: Codable {
    var status = ""
    var nextBooking: BookingDetails?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case nextBooking = "next_booking"
    }
}

class BookingDetails: Codable {
    var bookingId = ""
    var status = "active"
    var category = ""
    var categoryImage = ""
    var startDateString = ""
    var endDateString = ""
    var pickupLocation = ""
    var dropOffLocation = ""
    var price = ""
    var payments = [String]()
    var damageReported = false
    
    var startDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY HH:mm"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: startDateString)
        return date
    }
    
    var endDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM YYYY HH:mm"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: endDateString)
        return date
    }
    
    enum CodingKeys: String, CodingKey {
        case bookingId = "booking_id"
        case status = "status"
        case category = "category"
        case categoryImage = "category_image"
        case startDateString = "start"
        case endDateString = "end"
        case pickupLocation = "pickup_location"
        case dropOffLocation = "dropoff_location"
        case price = "price"
        case payments = "payments"
        case damageReported = "damage_reported"
    }
}
