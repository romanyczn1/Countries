//
//  CountriesViewControllerCoordinator.swift
//  WebSolutions
//
//  Created by Roman Bukh on 27.05.21.
//

import UIKit

final class CountriesViewControllerCoordinator: Coordinator {
    
    var presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let countriesViewController = CountriesTableViewController()
        let dataSource = CountriesViewControllerDataModel()
        countriesViewController.dataSource = dataSource
        countriesViewController.delegate = self
        presenter.pushViewController(countriesViewController, animated: true)
    }
}

extension CountriesViewControllerCoordinator: CountriesTableViewControllerDelegate {
    
    func coutriesTableViewControllerDidSelectCountry(_ country: String) {
        //bad story
        (presenter.viewControllers[0] as! MainViewController).dataSource.selectCountry(country: country)
        
        presenter.popViewController(animated: true)
    }
    
}
