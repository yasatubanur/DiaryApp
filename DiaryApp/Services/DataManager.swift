//
//  DataManager.swift
//  DiaryApp
//
//  Created by Tuba Nur YAŞA on 6.04.2022.
//

import UIKit
import CoreData

class DataManager: NSObject {
    var fetchResults = [NSFetchRequestResult]()
    static let shared = DataManager()
    typealias closure = () -> Void

    static func saveDiary(date: String, content: String) {
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
    
    static func getDiary() -> [DiaryModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diary")
        fetchRequest.returnsObjectsAsFaults = true
        
        do{
            let results = try context.fetch(fetchRequest)
            shared.fetchResults = results
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
    
    func deleteDiary(id: UUID, completion: (Bool) -> Void) {
        guard Self.shared.fetchResults.count > 0 ,
        let results = Self.shared.fetchResults as? [NSManagedObject] else {
            print("empty")
            return
        }
        let deleteDiary : NSManagedObject? = results.first { result in
            return id == result.value(forKey: "id") as! UUID
        }
        if let deleteObject = deleteDiary{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(deleteObject)
            
            var isSuccesfull = true
            do{
                try context.save()
            }catch{
                isSuccesfull = false
            }
            completion(isSuccesfull)
        }
    }
}
