//
//  NextBookingCoordinator.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit

class NextBookingModuleDepedencies: BaseModuleDependencies {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        super.init()
        self.window = window
    }
}

class NextBookingCoordinator: BaseCoordinator {
    private var nextBookingViewController: NextBookingViewController!
    
    func present() {
        guard let dependencies = dependencies as? NextBookingModuleDepedencies,
            let window = dependencies.window else { return }
        nextBookingViewController = NextBookingViewController.createViewController()
        let nextBookingInteractor = NextBookingInteractor(delegate: nextBookingViewController)
        nextBookingViewController.interactor = nextBookingInteractor
        window.rootViewController = nextBookingViewController
        window.makeKeyAndVisible()
    }
}
