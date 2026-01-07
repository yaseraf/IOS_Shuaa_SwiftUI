//
//  AppCoordinatorProtocol.swift
//  Shuaa

import Foundation

protocol AppCoordinatorProtocol: AnyObject,Coordinator {
    func startFlow(startWith:AuthCoordinator.AuthStartSceneType)
    func showHomeFlow()
}
