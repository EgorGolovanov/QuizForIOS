//
//  MainPlayViewController.swift
//  Quiz
//
//  Created by EgorMac on 26/06/2019.
//  Copyright © 2019 EgorMac. All rights reserved.
//

import UIKit
import CoreData

class MainPlayViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    var newQuestion : Questions?
    
    @IBOutlet weak var AddQuestionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel.text = "Hello \(actualUser)"
        AddQuestionButton.isEnabled = false
        if actualUser == "egor" {
            AddQuestionButton.isEnabled = true
        }
      //  let text = ReadFile()
       // saveQuestion()
        // Do any additional setup after loading the view.
    }
    
    
    func ReadFile() -> String {
        let file = "file.txt"
        var text = ""
        if let dir = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            
            do {
                text = try String(contentsOf: fileURL, encoding: .utf8)
            } catch {
                
            }
        }
        return text
    }
    
    func saveQuestion() {
        
        if let myContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            newQuestion = Questions(context: myContext)
        
            newQuestion?.category = "Системы счисления"
            newQuestion?.question = "101101 + 1010110 = ?"
            newQuestion?.firstAns = "10001011"
            newQuestion?.secondAns = "10000011"
            newQuestion?.thirdAns = "10010011"
            newQuestion?.fourthAns = "100001011"
            newQuestion?.rightAns = 2
            
            do {
                try myContext.save()
            } catch let error {
                print("Error when saving: \(error)")
            }
        }
    }

}
