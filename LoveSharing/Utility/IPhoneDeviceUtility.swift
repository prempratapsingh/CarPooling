//
//  IPhoneDeviceUtility.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

class IPhoneDeviceUtility {
    
    enum Device: String {
        case iPhoneX = "iPhone X"
        case iPhone4s = "iPhone 4 4s"
        case iPhone5s = "iPhone 5 5s"
        case iPhone66S78 = "iPhone 6 6S 7 8"
        case iPhone678Plus = "iPhone 6 7 8Plus"
        case unknown = "unknown"
    }
    
    static var isIPhoneX: Bool {
        return IPhoneDeviceUtility.current == .iPhoneX
    }
    
    static var hasSmallScreen: Bool {
        let currentDevice = IPhoneDeviceUtility.current
        return currentDevice == .iPhone4s || currentDevice == .iPhone5s || currentDevice == .iPhone66S78
    }
    
    static var current: Device {
        if UIDevice.current.model == "iPhone" {
            switch UIScreen.main.nativeBounds.height {
            case 960:
                return .iPhone4s
            case 1136:
                return .iPhone5s
            case 1334:
                return .iPhone66S78
            case 1920, 2208:
                return .iPhone678Plus
            case 2436:
                return .iPhoneX
            default:
                return .unknown
            }
        }
        return .unknown
    }
}
