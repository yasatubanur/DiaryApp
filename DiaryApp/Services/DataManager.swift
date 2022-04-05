//
//  DataManager.swift
//  DiaryApp
//
//  Created by Tuba Nur YAŞA on 6.04.2022.
//

import UIKit
import CoreData

class DataManager: NSObject {

    func saveDiary(date: String, content: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let diary = NSEntityDescription.insertNewObject(forEntityName: "Diary", into: context)
        
        diary.setValue(date, forKey: "date")
        diary.setValue(content, forKey: "content")
        diary.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("saved")
        } catch {
            print("error!")
        }
    }
}
/*
 singleton yapısı
 model oluştrumak
 
 */
 
