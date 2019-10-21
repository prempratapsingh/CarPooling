//
//  BaseCoordinator.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import Foundation

class BaseCoordinator {
    var dependencies: BaseModuleDependencies?
    
    init(dependencies: BaseModuleDependencies?) {
        self.dependencies = dependencies
    }
}
