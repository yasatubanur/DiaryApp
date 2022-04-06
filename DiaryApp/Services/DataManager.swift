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
    
    func getDiary() -> [DiaryModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diary")
        fetchRequest.returnsObjectsAsFaults = true
        
        do{
            let results = try context.fetch(fetchRequest)
            var diaryArray = [DiaryModel]()
            for result in results as! [NSManagedObject]{
                var diaryModel = DiaryModel()
                if let id = result.value(forKey: "id") as? UUID {
                    diaryModel.id = id
                }
                if let date = result.value(forKey: "date") as? String {
                    diaryModel.date = date
                }
                if let content = result.value(forKey: "content") as? String {
                    diaryModel.content = content
                }
                diaryArray.append(diaryModel)
            }
            
            return diaryArray
        }catch{
            return []
        }
    }
}
/*
 singleton yapısı
 model oluştrumak
 
 */
 
