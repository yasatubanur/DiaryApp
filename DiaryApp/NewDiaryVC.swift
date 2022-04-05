//
//  NewDiaryVC.swift
//  DiaryApp
//
//  Created by Tuba Nur YAŞA on 5.04.2022.
//

import UIKit
import CoreData

class NewDiaryVC: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        title = "New Diary"
        contentTextView.text = ""
        
        let date = Date()
        dateLabel.text = "\(date.get(.day)).\(date.get(.month)).\(date.get(.year))"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveDiary))
    }
}


//MARK: button functions
extension NewDiaryVC {
    @objc func saveDiary() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let diary = NSEntityDescription.insertNewObject(forEntityName: "Diary", into: context)
        
        diary.setValue(dateLabel.text, forKey: "date")
        diary.setValue(contentTextView.text, forKey: "content")
        diary.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("saved")
        } catch {
            print("error!")
        }
    }
}


extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

