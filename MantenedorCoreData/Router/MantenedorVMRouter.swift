//
//  MantenedorRouter.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//
import UIKit
import Foundation

protocol MantenedorVMProtocol {
    func goToCreateUser()
}
protocol MantenedorListProtocol {
    func goToList()
}
class MantenedorVMRouter: MantenedorVMProtocol,MantenedorListProtocol {
    weak var viewController: UIViewController?

    func goToList() {
        guard let viewController = viewController, let navigationController = viewController.navigationController else {
            print("Navigation controller is not available")
            return
        }
        let detailVC = ListViewController()
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func goToCreateUser() {
        guard let viewController = viewController, let navigationController = viewController.navigationController else {
            print("Navigation controller is not available")
            return
        }
        let detailVC = CreateViewController()
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func goToUpdateUser(users: UserModel) {
        guard let viewController = viewController, let navigationController = viewController.navigationController else {
            print("Navigation controller is not available")
            return
        }
        let detailVC = UpdateViewController(usersData: users)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func goToError() {
        guard let viewController = viewController, let navigationController = viewController.navigationController else {
            print("Navigation controller is not available")
            return
        }
        let detailVC = ErrorViewController()
        navigationController.pushViewController(detailVC, animated: true)
    }
}
