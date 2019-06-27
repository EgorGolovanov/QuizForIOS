//
//  RegisterViewController.swift
//  Quiz
//
//  Created by EgorMac on 25/06/2019.
//  Copyright © 2019 EgorMac. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!

    @IBOutlet weak var register: UIButton!
    
    var listUsers : [Users] = []
    var newUser : Users!

    var container : NSPersistentContainer!
    var context : NSManagedObjectContext!
    
    @IBAction func RegisterTapped(_ sender: UIButton) {
        
        if passwordTF.text != repeatPasswordTF.text {
            let alert = UIAlertController(title: "Ошибка", message: "Пароли не совпадают!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
            passwordTF.text = ""
            repeatPasswordTF.text = ""
        } else if userTF.text == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Введите имя!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
            passwordTF.text = ""
            repeatPasswordTF.text = ""
        } else if passwordTF.text == "" || repeatPasswordTF.text == "" {
            let alert = UIAlertController(title: "Ошибка", message: "Введите пароль!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
            passwordTF.text = ""
            repeatPasswordTF.text = ""
        } else if CheckUserName(userName: userTF.text!)  {
            let alert = UIAlertController(title: "Ошибка", message: "Пользователь с таким именем уже существует!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
            userTF.text = ""
            passwordTF.text = ""
            repeatPasswordTF.text = ""
        } else {
            saveUser(userName: userTF.text!, password: passwordTF.text!)
            if let nvc = navigationController {
                nvc.popViewController(animated: true)
            }
        }
    }
    
    func fetchModels() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        let request: NSFetchRequest<Users> = Users.fetchRequest()
        
        listUsers = try! context.fetch(request)
    }
    
    func CheckUserName(userName: String) -> Bool {
        fetchModels()
        for user in listUsers {
            if (userName == user.userName) {
                return true
            }
        }
        return false
    }
    
    func saveUser(userName: String, password: String) {
        
        if let myContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            newUser = Users(context: myContext)
        
            newUser.password = passwordTF.text
            newUser.userName = userTF.text
            newUser.uid = 1
        
            do {
                try myContext.save()
            } catch let error {
                print("Error when saving: \(error)")
            }
        }
    }
}
