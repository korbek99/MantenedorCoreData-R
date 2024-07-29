//
//  ErrorViewController.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    // MARK: - Properties

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Ocurrió un error."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reintentar", for: .normal)
        button.addTarget(self, action: #selector(retryAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(messageLabel)
        view.addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Actions

    @objc private func retryAction() {
        // Implement your retry logic here
        print("Retry button tapped")
    }
}

