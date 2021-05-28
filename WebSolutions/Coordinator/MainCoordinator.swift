//
//  MainCoirdinator.swift
//  WebSolutions
//
//  Created by Roman Bukh on 27.05.21.
//

import UIKit

final class MainViewControllerCoordiantor: Coordinator {
    
    private let window: UIWindow
    var presenter: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.presenter = UINavigationController()
    }
    
    public func start() {
        
        let vc = MainViewController()
        vc.title = "VPN"
        let dataSource = MainViewControllerDataModel()
        vc.dataSource = dataSource
        vc.delegate = self
        dataSource.delegate = vc
        presenter.pushViewController(vc, animated: true)
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
    
    private func showCountriesListViewController() {
        let countriesViewControllerCoordinator = CountriesViewControllerCoordinator(presenter: presenter)
        countriesViewControllerCoordinator.start()
    }
}

extension MainViewControllerCoordiantor: MainViewControllerDelegate {
    
    func countryTapped() {
        showCountriesListViewController()
    }
}
