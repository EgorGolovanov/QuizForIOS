//
//  ViewController.swift
//  Quiz
//
//  Created by EgorMac on 25/06/2019.
//  Copyright © 2019 EgorMac. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController {

    @IBOutlet weak var sighIn: UIButton!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    
    var listUsers : [Users] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var container : NSPersistentContainer!
    var context : NSManagedObjectContext!
    public var User : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func CheckAutorization(_ sender: UIButton) {
        fetchModels()
        var checkLogin: Bool = false
        for user in listUsers {
            print("userName: \(user.userName!), password: \(user.password!)")
            if (userTF.text == user.userName && passwordTF.text == user.password) {
                actualUser = userTF.text!
                checkLogin = true
            }
        }
        if checkLogin {
            performSegue(withIdentifier: "mySegueID", sender: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Имя или пароль не верны!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
            passwordTF.text = ""
        }
    }
    
    func fetchModels() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        let request: NSFetchRequest<Users> = Users.fetchRequest()
        
        listUsers = try! context.fetch(request)
    }

}


