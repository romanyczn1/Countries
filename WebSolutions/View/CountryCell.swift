//
//  CountryCell.swift
//  WebSolutions
//
//  Created by Roman Bukh on 27.05.21.
//

import UIKit

final class CountryCell: UITableViewCell {
    
    static let reuseIdentidier: String = "CountryCell"
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        setUpImageView()
    }
    
    public func configure(with country: String) {
        textLabel?.text = country
        let imageName = country.lowercased()
        imageView?.image = UIImage(named: imageName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        imageView?.layer.cornerRadius = (imageView?.bounds.height)!/2
        
    }
    
    private func setUpImageView() {
        imageView?.clipsToBounds = true
        imageView?.contentMode = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
