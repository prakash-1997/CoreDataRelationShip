//
//  ViewController.swift
//  CoreDataRelationShip
//
//  Created by prakash on 30/08/20.
//  Copyright © 2020 prakash. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    
    var task = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.endEditing(true)
    }

    
    
    @IBAction func saveBtn(_ sender: UIButton) {
        
       
        
        let userTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: contex)
        userTask.setValue("21", forKey: "id")
        userTask.setValue("rudra", forKey: "name")
        userTask.setValue(txt3.text, forKey: "detail")
        
        let userData = User(context: contex)
               userData.id = txt1.text
               userData.name = txt2.text
               userData.add = txt3.text
               userData.toTask = NSSet(array: [userTask])
        saveData()
    }
    
    func saveData(){
        do {
            try contex.save()
        }catch{
            print("error: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func getData(_ sender: UIButton) {
        displayData()
    }
    
    func displayData() {
        var r1 = [User]()
        let dispay = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            r1 = try contex.fetch(dispay) as! [User]
        }catch{
            print(error.localizedDescription)
        }
        for item in r1 {
            print(item.id)
            print(item.name)
            print(item.add)
            
            var t = item.toTask?.allObjects
            for i in t!{
                var item1 = i as! Task
                print(item1.name)
                print(item1.id)
            }
        }
    }
    
}

