//
//  ViewControllerDataModel.swift
//  WebSolutions
//
//  Created by Roman Bukh on 21.05.21.
//

import Foundation

protocol MainViewControllerDataModelType {
    var connectionStatus: ConnectionStatus { get }
    var isCountrySelected: Bool { get }
    func getSelectedCountry() -> String?
    func selectCountry(country: String)
    func establishConnection()
    func disconnect()
}

protocol MainViewControllerDataModelDelegate: class {
    func updateViews(with country: String?)
    func connectionEstablished()
}

final class MainViewControllerDataModel: MainViewControllerDataModelType {
    
    private var selectedCountry: String?
    
    var isCountrySelected: Bool {
        return selectedCountry != nil
    }
    
    var connectionStatus: ConnectionStatus = .disconnected
    
    weak var delegate: MainViewControllerDataModelDelegate?
    
    var timer: Timer?
    
    func establishConnection() {
        connectionStatus = .connecting
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            let randomNumber = Int.random(in: 1...6)
            if randomNumber == 3 {
                timer.invalidate()
                self?.connectionStatus = .connected
                self?.delegate?.connectionEstablished()
            }
        }
        
    }
    
    func disconnect() {
        timer?.invalidate()
        connectionStatus = .disconnected
    }
    
    func getSelectedCountry() -> String? {
        return selectedCountry
    }
    
    func selectCountry(country: String) {
        selectedCountry = country
        delegate?.updateViews(with: selectedCountry)
    }
}

enum ConnectionStatus {
    case connecting
    case disconnected
    case connected
}
