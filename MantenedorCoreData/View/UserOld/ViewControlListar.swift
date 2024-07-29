//
//  ViewControlListar.swift
//  MantenedorCoreData
//
//  Created by Jose David Bustos H on 08-04-18.
//  Copyright © 2018 Jose David Bustos H. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ViewControlListar: UIViewController , UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    var str_mensaje:String = "";
    
    @IBOutlet weak var tableView: UITableView!
    
   // open var context: NSManagedObjectContext!
    
    var fetchedResultsController: NSFetchedResultsController<Users>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // LoadData()
        
        configureFetchedResultsController()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
            
        }

    }
    
    func configureFetchedResultsController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let animalsFetchRequest = NSFetchRequest<Users>(entityName: "Users")
        let primarySortDescriptor = NSSortDescriptor(key: "nombre", ascending: true)
        let secondarySortDescriptor = NSSortDescriptor(key: "apellido", ascending: true)
        animalsFetchRequest.sortDescriptors = [primarySortDescriptor, secondarySortDescriptor]
        
        self.fetchedResultsController = NSFetchedResultsController<Users>(
            fetchRequest: animalsFetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: "nombre",
            cacheName: nil)
        
        self.fetchedResultsController.delegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let animal = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = animal.nombre
        //cell.detailTextLabel?.text = animal.habitat
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section] 
            return currentSection.name
        }
        
        return nil
    }

    
    func LoadData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
               // let IdeString:String! = data.value(forKey: "ide") as? String
                //var IdeString:String?  = nil
                // IdeString = data.value(forKey: "ide") as? String
                
               /* if IdeString != nil {
                    self.TextIDE.text = IdeString
                     print(IdeString ?? <#default value#>)
                }
                
                print(data.value(forKey: "username") as! String)
                
                self.TextNombre.text = data.value(forKey: "nombre") as? String
                self.TextApellido.text = data.value(forKey: "apellido") as? String
                self.TextIEdad.text = data.value(forKey: "edad") as? String
                */
            }
            
        } catch {
            
            print("Failed")
        }
        

    }
}
