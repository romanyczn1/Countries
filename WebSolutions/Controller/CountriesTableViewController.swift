//
//  CountriesViewController.swift
//  WebSolutions
//
//  Created by Roman Bukh on 27.05.21.
//

import UIKit

protocol CountriesTableViewControllerDelegate: class {
    func coutriesTableViewControllerDidSelectCountry(_ country: String)
}

final class CountriesTableViewController: UITableViewController {
    
    var dataSource: CountriesViewControllerDataModelType!
    
    var delegate: CountriesTableViewControllerDelegate!
    
    override func viewDidLoad() {
        
        tableView.register(CountryCell.self, forCellReuseIdentifier: CountryCell.reuseIdentidier)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.reuseIdentidier, for: indexPath) as? CountryCell {
            cell.configure(with: dataSource.getCountry(for: indexPath.row))
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getNumberOfCountries()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = dataSource.getCountry(for: indexPath.row)
        delegate?.coutriesTableViewControllerDidSelectCountry(country)
    }
}
