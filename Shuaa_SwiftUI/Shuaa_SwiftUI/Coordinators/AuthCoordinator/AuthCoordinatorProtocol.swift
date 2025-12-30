//
//  AuthCoordinatorProtocol.swift
//  mahfazati
//
//  Created by Mohammmed on 22/07/2024.
//  Copyright © 2024 Mohammed Mathkour. All rights reserved.
//

import Foundation
import SwiftUI
import FlagAndCountryCode

protocol AuthCoordinatorProtocol: AnyObject,Coordinator {
    func openLoginScene()
    func openLandingScene()
    func openVerifyPinScene(username: String, password: String)
    func openForgotPasswordScene(forgotType:ForgotDataEnum)
    func openConfirmOtpScene(forgotType:ForgotDataEnum, nin :String, qID: String, username: String)
    func openChangePasswordScene(nin: String, qID: String, username: String)
    func openChangePinScene()
    func openSetNewPinScene(username: String, password: String)
//    func openBoardingScene()
//    func openCountiesScene(delegate: CountriesListDelegate,selectCountry:CountryFlagInfo?)
}
