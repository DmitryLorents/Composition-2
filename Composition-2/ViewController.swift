//
//  ViewController.swift
//  Composition-2
//
//  Created by Дмитрий Лоренц on 26.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Make an order", for: .normal)
        button.backgroundColor = .red
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

