//
//  UserModel.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//

import Foundation

struct UserModel {
    var ide: String
    var nombre: String
    var apellido: String
    var usuario: String
    var password: String

    init(ide: String,
         nombre: String,
         apellido: String,
         usuario: String,
         password: String) {
        self.ide = ide
        self.nombre = nombre
        self.apellido = apellido
        self.usuario = usuario
        self.password = password
    }
}

