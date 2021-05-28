//
//  ViewController.swift
//  WebSolutions
//
//  Created by Roman Bukh on 21.05.21.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func countryTapped()
}

class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    var dataSource: MainViewControllerDataModelType!
    
    private let connectionButton: PulsatingButton = {
        let btn = PulsatingButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let countryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let connectionInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setUpBindings()
        updateViews(with: dataSource.getSelectedCountry())
    }
    
    private func setUpBindings() {
        
        connectionButton.addTarget(self, action: #selector(connectionButtonTapped), for: .touchUpInside)
        
        let labelTapGesture = UITapGestureRecognizer()
        labelTapGesture.addTarget(self, action: #selector(countryTapped))
        countryLabel.addGestureRecognizer(labelTapGesture)
        let imageTapGesture = UITapGestureRecognizer()
        imageTapGesture.addTarget(self, action: #selector(countryTapped))
        countryImageView.addGestureRecognizer(imageTapGesture)
    }
    
    @objc private func connectionButtonTapped() {
        if dataSource.connectionStatus != .connecting && dataSource.isCountrySelected == true{
            dataSource.establishConnection()
            connectionButton.pulse()
        }
    }
    
    @objc private func countryTapped() {
        
        //show next screen
        dataSource.disconnect()
        delegate?.countryTapped()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(connectionButton)
        view.addSubview(countryLabel)
        view.addSubview(countryImageView)
        view.addSubview(connectionInfoLabel)
        
        connectionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        connectionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        connectionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        connectionButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        countryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 48 + 5).isActive = true
        countryLabel.bottomAnchor.constraint(equalTo: connectionButton.topAnchor, constant: -100).isActive = true
        
        countryImageView.trailingAnchor.constraint(equalTo: countryLabel.leadingAnchor, constant: -10).isActive = true
        countryImageView.centerYAnchor.constraint(equalTo: countryLabel.centerYAnchor).isActive = true
        countryImageView.heightAnchor.constraint(equalTo: countryLabel.heightAnchor).isActive = true
        countryImageView.widthAnchor.constraint(equalTo: countryLabel.heightAnchor).isActive = true
        
        connectionInfoLabel.centerXAnchor.constraint(equalTo: connectionButton.centerXAnchor).isActive = true
        connectionInfoLabel.topAnchor.constraint(equalTo: connectionButton.bottomAnchor, constant: 100).isActive = true
    }
}

extension MainViewController: MainViewControllerDataModelDelegate {
    
    func updateViews(with country: String?) {
        if country != nil {
            self.countryLabel.text = country
            let imageName = country!.lowercased()
            self.countryImageView.image = UIImage(named: imageName)
        } else {
            self.countryLabel.text = "Select country"
            self.countryImageView.image = UIImage(named: "emptyimage")
        }
    }
    
    func connectionEstablished() {
        connectionButton.stopPulse()
        connectionInfoLabel.text = "Connection established"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.connectionInfoLabel.text = ""
        }
    }
}

