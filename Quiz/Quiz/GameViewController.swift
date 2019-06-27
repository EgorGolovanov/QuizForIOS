//
//  GameViewController.swift
//  Quiz
//
//  Created by EgorMac on 25/06/2019.
//  Copyright © 2019 EgorMac. All rights reserved.
//

import UIKit
import CoreData



class GameViewController: UIViewController {

    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    @IBOutlet weak var fourthAnswer: UIButton!
    
    @IBOutlet weak var questionTextBox: UITextView!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var ErrorsLabel: UILabel!
    
    var listQuestions : [Questions] = []
    var listRecords : [Records] = []
    var actualQuestion : Questions!
    var errorCount : Int32 = 0
    var rightAnswerCount : Int32 = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var container : NSPersistentContainer!
    var context : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getListQuestions()
        CheckErrors()
        changeActualQuestion()
    }
    
    func getListQuestions() {
        fetchModels()
    }
    
    func fetchModels() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        let request: NSFetchRequest<Questions> = Questions.fetchRequest()

        listQuestions = try! context.fetch(request)
    }
    
    func fetchRecords() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            return
        }
        
        let request: NSFetchRequest<Records> = Records.fetchRequest()
        
        listRecords = try! context.fetch(request)
    }
    
    func changeActualQuestion() {
        if listQuestions.count == 0 || errorCount == 3 {
            gameOver()
        }
        else {
            actualQuestion = listQuestions.randomElement()
            let index = listQuestions.firstIndex(of: actualQuestion!)
            listQuestions.remove(at: index!)
            
            CategoryLabel.text = actualQuestion?.category
            questionTextBox.text = actualQuestion.question
            firstAnswer.setTitle(actualQuestion.firstAns, for: .normal)
            secondAnswer.setTitle(actualQuestion.secondAns, for: .normal)
            thirdAnswer.setTitle(actualQuestion.thirdAns, for: .normal)
            fourthAnswer.setTitle(actualQuestion.fourthAns, for: .normal)
        }
        
    }
    
    func gameOver() {
        //alarm "end
        if errorCount == 3 {
            let alert = UIAlertController(title: "Конец игры", message: "Вы допустили максимальное количество ошибок!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            
            alert.addAction(OKAction)
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Поздравляем!", message: "Вы ответили на все вопросы!", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)
            
            alert.addAction(OKAction)
            
            present(alert, animated: true, completion: nil)
        }
        CheckNewRecord()
        if let nvc = navigationController {
            nvc.popViewController(animated: true)
        }
       // present(MainPlayViewController, animated: true, completion: nil)
    }
    
    func CheckNewRecord() {
        fetchRecords()
        var count: Int = 0
        var check: Bool = false
        for item in listRecords {
            if item.user == actualUser && item.countRightAnswer <= rightAnswerCount {
                update(index: count)
                check = true
            }
            count += 1
        }
        if listRecords == [] || !check {
            saveRecord()
        }
    }
    
    func update(index : Int) {
        if let myContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newRecord = listRecords[index]
            newRecord.countRightAnswer = rightAnswerCount
            
            do{
                listRecords[index] = newRecord
                
                try myContext.save()
            } catch let error {
                print("error when saving: \(error)")
            }
        }
    }
    
    func saveRecord() {
        if let myContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newRecord = Records(context: myContext)
            
            newRecord.countRightAnswer = rightAnswerCount
            newRecord.user = actualUser
            
            do {
                try myContext.save()
            } catch let error {
                print("Error when saving: \(error)")
            }
        }
    }
    
    func CheckErrors() {
        if errorCount == 0 {
            ErrorsLabel.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if errorCount == 1 {
            ErrorsLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else if errorCount == 2 {
            ErrorsLabel.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        } else {
            ErrorsLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    @IBAction func firstAnswerTapped(_ sender: UIButton) {
        if actualQuestion?.rightAns == 1 {
            rightAnswerCount += 1
            
        }
        else
        {
            errorCount += 1
            ErrorsLabel.text = "\(errorCount) Errors"
            CheckErrors()
        }
        changeActualQuestion()
    }
    
    
    @IBAction func secondAnswerTapped(_ sender: UIButton) {
        if actualQuestion?.rightAns == 2 {
            rightAnswerCount += 1
        }
        else
        {
            errorCount += 1
            ErrorsLabel.text = "\(errorCount) Errors"
            CheckErrors()
        }
        changeActualQuestion()
    }
    
    @IBAction func thirdAnswerTapped(_ sender: UIButton) {
        if actualQuestion?.rightAns == 3 {
            rightAnswerCount += 1
        }
        else
        {
            errorCount += 1
            ErrorsLabel.text = "\(errorCount) Errors"
            CheckErrors()
        }
        changeActualQuestion()
    }
    
    @IBAction func fourthAnswerTapped(_ sender: UIButton) {
        if actualQuestion?.rightAns == 4 {
            rightAnswerCount += 1
            
        }
        else
        {
            errorCount += 1
            ErrorsLabel.text = "\(errorCount) Errors"
            CheckErrors()
        }
        changeActualQuestion()
    }
}
