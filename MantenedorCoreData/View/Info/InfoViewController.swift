//
//  InfoViewController.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Properties

    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nombre de la Aplicación: MantenedorCoreData"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creationDateLabel: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        //let creationDate = dateFormatter.string(from: Date()) 
        label.text = "Fecha de Creación: \("2016-07-29")"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let appTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Tipo de App: Solo Testing"
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(appNameLabel)
        stackView.addArrangedSubview(creationDateLabel)
        stackView.addArrangedSubview(appTypeLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

