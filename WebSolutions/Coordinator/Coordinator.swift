//
//  Coordinator.swift
//  WebSolutions
//
//  Created by Roman Bukh on 27.05.21.
//

import UIKit

protocol Coordinator {
    var presenter: UINavigationController { get }
    func start()
}
