//
//  NextBookingViewController.swift
//  LoveSharing
//
//  Created by Prem Pratap Singh on 19/10/19.
//  Copyright © 2019 xparrow. All rights reserved.
//

import UIKit
import SVProgressHUD

class NextBookingViewController: BaseViewController {

    class func createViewController() -> NextBookingViewController? {
        let storyboard = UIStoryboard(name: "NextBookingStoryboard", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "NextBookingViewController")
            as? NextBookingViewController {
            return viewController
        }
        return nil
    }
    
    @IBOutlet private weak var vehicleImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var timerContainerView: UIView!
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var timerViewHeightConstraint: NSLayoutConstraint!
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviewsVisibility(to: false)
        configureLabels()
        configureTimerView()
        getBookingDetails()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    private func configureLabels() {
        titleLabel.font = UIFont.systemFont(ofSize: IPhoneDeviceUtility.hasSmallScreen ? 25 : 35)
        titleLabel.textColor = .black
        titleLabel.text = "Your booking will be activated soon"
        descriptionLabel.font = UIFont.systemFont(ofSize: IPhoneDeviceUtility.hasSmallScreen ? 16 : 18)
        descriptionLabel.textColor = .black
        descriptionLabel.text = "Once the countdown ends, your car digital key will be activated and you could start enjoying Lovesharing!"
        timerLabel.font = UIFont.systemFont(ofSize: IPhoneDeviceUtility.hasSmallScreen ? 20 : 26)
        timerLabel.textColor = .black
        timerLabel.text = "00 : 00 : 00"
    }
    
    private func configureTimerView() {
        if IPhoneDeviceUtility.hasSmallScreen {
            timerViewHeightConstraint.constant = 35
            timerContainerView.layoutIfNeeded()
        }
        timerContainerView.layer.cornerRadius = timerContainerView.frame.height * 0.5
        timerContainerView.layer.borderWidth = 1
        timerContainerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setSubviewsVisibility(to isVisible: Bool) {
        UIView.animate(withDuration: 0.2,
                       animations: {
                        let alpha: CGFloat = isVisible ? 1 : 0
                        self.vehicleImage.alpha = alpha
                        self.titleLabel.alpha = alpha
                        self.descriptionLabel.alpha = alpha
                        self.timerContainerView.alpha = alpha
        })
        
    }
    
    private func startTimer() {
        guard let interactor = interactor as? NextBookingInteractor,
            !interactor.isTimeOver else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1,
                                         repeats: true,
                                         block: { [weak self] _ in
                                            guard let strongSelf = self else { return }
                                            let timerComponents = interactor.timerComponents
                                            let formattedComponents = timerComponents.map { $0 < 10 ? "0\($0)" : "\($0)" }
                                            strongSelf.timerLabel.text = "\(formattedComponents[0]) : \(formattedComponents[1]) : \(formattedComponents[2])"
                                            
        })
    }
    
    private func getBookingDetails() {
        guard let interactor = interactor as? NextBookingInteractor else { return }
        interactor.getBookingDetails { [weak self] _, error in
            guard let strongSelf = self,
                error == nil else {
                    self?.presentError(messege: error!)
                    return
            }
            strongSelf.loadVehicleImage()
        }
    }
    
    private func loadVehicleImage() {
        guard let interactor = interactor as? NextBookingInteractor else { return }
        interactor.loadVehicleImage { [weak self] image, error in
            guard let strongSelf = self,
                let image = image,
                error == nil else {
                    self?.presentError(messege: error!)
                    return
            }
            strongSelf.vehicleImage.image = image
            strongSelf.startTimer()
            strongSelf.setSubviewsVisibility(to: true)
        }
    }
}

