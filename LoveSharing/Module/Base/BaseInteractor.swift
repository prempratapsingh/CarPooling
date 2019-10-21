//
//  BaseInteractor.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

class BaseInteractor {
    weak var delegate: BaseViewController!
    
    init(delegate: BaseViewController) {
        self.delegate = delegate
    }
}
