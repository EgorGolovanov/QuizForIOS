//
//  AddQuestionViewController.swift
//  Quiz
//
//  Created by EgorMac on 27/06/2019.
//  Copyright © 2019 EgorMac. All rights reserved.
//

import UIKit
import CoreData

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var question: UITextField!
    @IBOutlet weak var firstAns: UITextField!
    @IBOutlet weak var secondAns: UITextField!
    @IBOutlet weak var thirdAns: UITextField!
    @IBOutlet weak var fourthAns: UITextField!
    @IBOutlet weak var rightAns: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var listQuestion: [Questions] = []
    var newQuestion: Questions?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchModels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if category.text == "" || question.text == "" || firstAns.text == "" || secondAns.text == "" ||
            thirdAns.text == "" || fourthAns.text == "" || rightAns.text == "" {
            addButton.isEnabled = false
        } else {
            addButton.isEnabled = true
        }
    }
    
    func fetchModels() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        let request: NSFetchRequest<Questions> = Questions.fetchRequest()
        
        listQuestion = try! context.fetch(request)
    }
    
    @IBAction func AddTapped(_ sender: UIButton) {
        saveQuestion()
        clearText()
    }
    
    func clearText() {
        category.text = ""
        question.text = ""
        firstAns.text = ""
        secondAns.text = ""
        thirdAns.text = ""
        fourthAns.text = ""
        rightAns.text = ""
    }
    
    func saveQuestion() {
        
        if let myContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            newQuestion = Questions(context: myContext)
            
            newQuestion?.category = category.text
            newQuestion?.question = question.text
            newQuestion?.firstAns = firstAns.text
            newQuestion?.secondAns = secondAns.text
            newQuestion?.thirdAns = thirdAns.text
            newQuestion?.fourthAns = fourthAns.text
            newQuestion?.rightAns = Int32(rightAns.text!)!
            
            do {
                try myContext.save()
            } catch let error {
                print("Error when saving: \(error)")
            }
        }
    }
    

}
