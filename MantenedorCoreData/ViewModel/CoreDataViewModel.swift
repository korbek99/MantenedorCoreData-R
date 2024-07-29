//
//  CoreDataViewModel.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 28-07-24.
//  Copyright © 2024 Jose David Bustos H. All rights reserved.
//
import Foundation
import UIKit
import CoreData

class CoreDataViewModel {
    
    // MARK: - Delete
    func deleteUser(uuid: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "ide == %@", uuid)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let objectToDelete = results.first as? NSManagedObject {
                context.delete(objectToDelete)
                try context.save()
                print("User deleted successfully")
            } else {
                print("No user found with UUID: \(uuid)")
            }
        } catch {
            print("Failed to delete user: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Update
    func updateUser(uuid: String, with updatedUser: UserModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Users")
        fetchRequest.predicate = NSPredicate(format: "ide == %@", uuid)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let objectToUpdate = results.first as? NSManagedObject {
                //objectToUpdate.setValue(updatedUser.ide, forKey: "ide")
                objectToUpdate.setValue(updatedUser.nombre, forKey: "nombre")
                objectToUpdate.setValue(updatedUser.apellido, forKey: "apellido")
                objectToUpdate.setValue(updatedUser.usuario, forKey: "user")
                objectToUpdate.setValue(updatedUser.password, forKey: "password")
                try context.save()
                print("User updated successfully")
            } else {
                print("No user found with UUID: \(uuid)")
            }
        } catch {
            print("Failed to update user: \(error.localizedDescription)")
        }
    }
    
    // MARK: - List
        func listUsers() -> [UserModel] {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
            
            do {
                let results = try context.fetch(fetchRequest)
                let users = results.compactMap { user in
                    return UserModel(
                        ide: user.ide ?? "",
                        nombre: user.nombre ?? "",
                        apellido: user.apellido ?? "",
                        usuario: user.user ?? "",
                        password: user.password ?? ""
                    )
                }
                print("Users fetched successfully")
                return users
            } catch {
                print("Failed to fetch users: \(error.localizedDescription)")
                return []
            }
    }
    func fetchUsers() -> [UserModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Users")
        do {
            let results = try context.fetch(fetchRequest)
            return results.compactMap { result in
                guard
                    let ide = result.value(forKey: "ide") as? String,
                    let nombre = result.value(forKey: "nombre") as? String,
                    let apellido = result.value(forKey: "apellido") as? String,
                    let usuario = result.value(forKey: "user") as? String,
                    let password = result.value(forKey: "password") as? String
                else {
                    return nil
                }
                
                return UserModel(
                    ide: ide,
                    nombre: nombre,
                    apellido: apellido,
                    usuario: usuario,
                    password: password
                )
            }
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }

    // MARK: - Save
    func saveUser(user: UserModel) {
        let newUUID = UUID()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Users", in: context) else {
            print("Failed to find entity description for 'Users'")
            return
        }
        
        let newUser = NSManagedObject(entity: entity, insertInto: context)

        newUser.setValue(newUUID.uuidString, forKey: "ide")
        newUser.setValue(user.nombre, forKey: "nombre")
        newUser.setValue(user.apellido, forKey: "apellido")
        newUser.setValue(user.usuario, forKey: "user")
        newUser.setValue(user.password, forKey: "password")
        
        do {
            try context.save()
            fetchUsers()
            print("User saved successfully")
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }

}
