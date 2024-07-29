//
//  ViewControlCreate.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 08-04-18.
//  Copyright © 2018 Jose David Bustos H. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewControlCreate: UIViewController {
    var str_mensaje:String = "";
    
    @IBOutlet weak var TextIDE: UITextField!
    
    @IBOutlet weak var TextNombre: UITextField!
    
    @IBOutlet weak var TextApellido: UITextField!
    
    @IBOutlet weak var TextUser: UITextField!
    
    @IBOutlet weak var TextPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Grabar(_ sender: Any) {
        if ValidField() == true {
            
            
            do {
                
                
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let context = appDelegate.persistentContainer.viewContext
                
                let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
                let newUser = NSManagedObject(entity: entity!, insertInto: context)
                
                
                newUser.setValue(self.TextIDE.text, forKey: "ide")
                newUser.setValue(self.TextNombre.text, forKey: "nombre")
                newUser.setValue(self.TextApellido.text, forKey: "apellido")
                newUser.setValue(self.TextUser.text, forKey: "user")
                newUser.setValue(self.TextPass.text, forKey: "password")
                do {
                    
                    try context.save()
                    
                } catch {
                    
                    print("Failed saving")
                }
                
                
                print("saving Datas")
                
                ClearField()
                
                str_mensaje = "Se Grabaron sus Datos"
                
                let alert = UIAlertController(title: "Alert", message: str_mensaje, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } catch {
                print("Failed Saving")
            }
            
            
            
        }else{
            
            let alert = UIAlertController(title: "Alert", message: str_mensaje, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        

    }
    
    
    func ClearField()
    {
        TextIDE.text = ""
        TextNombre.text = ""
        TextApellido.text = ""
        TextUser.text = ""
        TextPass.text = ""
    }
    func ValidField() -> Bool
    {
        var isValid = true;
        
        if TextIDE.text == ""   {
            str_mensaje = "Campo IDE vacio"
            isValid = false
            return isValid
        }
        if TextNombre.text == ""   {
            str_mensaje = "Campo Nombre vacio"
            isValid = false
            return isValid
        }
        if TextApellido.text == ""   {
            str_mensaje = "Campo Apellido vacio"
            isValid = false
            return isValid
        }
        if TextUser.text == ""   {
            str_mensaje = "Campo User vacio"
            isValid = false
            return isValid
        }
        if TextPass.text == ""   {
            str_mensaje = "Campo Password vacio"
            isValid = false
            return isValid
        }
        return isValid;
    }

    
}
