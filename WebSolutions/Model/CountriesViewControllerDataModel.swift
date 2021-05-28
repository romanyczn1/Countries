//
//  CountriesViewControllerDataModel.swift
//  WebSolutions
//
//  Created by Roman Bukh on 27.05.21.
//

protocol CountriesViewControllerDataModelType {
    func getNumberOfCountries() -> Int
    func getCountry(for index: Int) -> String
}

final class CountriesViewControllerDataModel: CountriesViewControllerDataModelType {
    
    private let countries: [String] = ["China", "England", "Italy", "Russia", "Spain", "Ukraine"]

    func getNumberOfCountries() -> Int {
        return countries.count
    }
    
    func getCountry(for index: Int) -> String {
        return countries[index]
    }
}
