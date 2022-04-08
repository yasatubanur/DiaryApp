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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveDiary))
        
        contentTextView.text = ""
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        let date = Date()
        dateLabel.text = "\(date.get(.day)).\(date.get(.month)).\(date.get(.year))"
    }
}


//MARK: button functions
extension NewDiaryVC {
    @objc func saveDiary() {
        guard let date = dateLabel.text, let content = contentTextView.text else { return }
        DataManager.saveDiary(date: date, content: content)
    }
}




