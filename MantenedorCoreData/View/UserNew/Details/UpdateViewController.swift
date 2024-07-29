//
//  UpdateViewController.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    private var usersData: UserModel
    private var router: MantenedorVMRouter?
    private var coreDataViewModel = CoreDataViewModel()
    var str_mensaje: String = ""
    var title_mensaje: String = ""
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    private let textNombre: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let textApellido: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Last Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let textUser: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "User"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let textPass: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(grabar), for: .touchUpInside)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10.0
        
        return button
    }()
    
       init(usersData: UserModel) {
           self.usersData = usersData
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        setupLoadData()
        router = MantenedorVMRouter()
        router?.viewController = self
        setupUI()
    }
    
    private func setupLoadData(){
        textNombre.text = usersData.nombre
        textApellido.text = usersData.apellido
        textUser.text = usersData.usuario
        textPass.text = usersData.password
    }
    
    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textNombre.heightAnchor.constraint(equalToConstant: 30),
            textApellido.heightAnchor.constraint(equalToConstant: 30),
            textUser.heightAnchor.constraint(equalToConstant: 30),
            textPass.heightAnchor.constraint(equalToConstant: 30),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill

        stackView.addArrangedSubview(textNombre)
        stackView.addArrangedSubview(textApellido)
        stackView.addArrangedSubview(textUser)
        stackView.addArrangedSubview(textPass)
        stackView.addArrangedSubview(saveButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
    
    @objc private func grabar() {
        if validField() {
            let user = UserModel(
                ide: UUID().uuidString,
                nombre: textNombre.text ?? "",
                apellido: textApellido.text ?? "",
                usuario: textUser.text ?? "",
                password: textPass.text ?? ""
            )
            coreDataViewModel.updateUser(uuid: usersData.ide, with: user)
            clearField()
            router?.goToList()
        } else {
            router?.goToError()
            //AlertUtils.showAlert(on: self, code: 2)
        }
    }
 
}
extension UpdateViewController {
    
    private func clearField() {
        textNombre.text = ""
        textApellido.text = ""
        textUser.text = ""
        textPass.text = ""
    }

    private func validField() -> Bool {
        var isValid = true

        if textNombre.text?.isEmpty ?? true {
            str_mensaje = "Campo Nombre vacío"
            isValid = false
        } else if textApellido.text?.isEmpty ?? true {
            str_mensaje = "Campo Apellido vacío"
            isValid = false
        } else if textUser.text?.isEmpty ?? true {
            str_mensaje = "Campo Usuario vacío"
            isValid = false
        } else if textPass.text?.isEmpty ?? true {
            str_mensaje = "Campo Contraseña vacío"
            isValid = false
        }
        return isValid
    }

}
