//
//  NextBookingInteractor.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

typealias BookingDetailsCompletionHandler = (Booking?, String?) -> Void

class NextBookingInteractor: BaseInteractor {
    var bookingDetails: Booking?
    
    var isTimeOver: Bool {
        guard let bookingDetails = bookingDetails,
                   let nextBooking = bookingDetails.nextBooking,
                   let startDate = nextBooking.startDate else { return true }
        let rightNow = Date()
        let isOver =  rightNow > startDate
        return isOver
    }
    
    var timerComponents: [Int] {
        guard let bookingDetails = bookingDetails,
            let nextBooking = bookingDetails.nextBooking,
            let startDate = nextBooking.startDate else { return [] }
        
        let calendar = Calendar.current
        let startDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: startDate)
        let rightNow = Date()
        let rightNowDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: rightNow)
    
        var dDifference = startDateComponents.day! - rightNowDateComponents.day!
        if dDifference < 0 {
            dDifference = 0
        }
        
        var hDifference = startDateComponents.hour! - rightNowDateComponents.hour!
        if hDifference < 0 {
            hDifference = 0
        }
        var mDifference = startDateComponents.minute! - rightNowDateComponents.minute!
        if mDifference < 0 {
            mDifference = 0
        }
        var sDifference = 60 + (startDateComponents.second! - rightNowDateComponents.second!)
        if sDifference < 0 {
            sDifference = 0
        }
        return [(dDifference * 24 + hDifference), mDifference, sDifference]
    }
    
    func getBookingDetails(completionHandler: @escaping BookingDetailsCompletionHandler) {
        let bookingDetailsService = BookingDetailsService()
        bookingDetailsService.getBookingDetails { [weak self] bookingDetails, error in
            guard let strongSelf = self else { return }
            strongSelf.bookingDetails = bookingDetails
            completionHandler(bookingDetails, error)
        }
    }
    
    func loadVehicleImage(completionHandler: @escaping ImageDownloadCompletionHandler) {
        guard let bookingDetails = bookingDetails,
            let nextBooking = bookingDetails.nextBooking else {
                let error = "Oops! Couldn't find booking details!".localizedCapitalized
            completionHandler(nil, error)
            return
        }
        let mediaDownloadService = MediaDownloadService()
        mediaDownloadService.downloadImage(from: nextBooking.categoryImage,
                                           completionHandler: completionHandler)
    }
}
