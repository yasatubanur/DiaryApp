//
//  ViewController.swift
//  DiaryApp
//
//  Created by Tuba Nur YAŞA on 5.04.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var diaries : [DiaryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        diaries = DataManager.getDiary()
        tableView.reloadData()
    }
    
    func setup() {
        navigationItem.title = "My Diary"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDiary))
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}


//MARK: button functions
extension ViewController {
    @objc func addDiary() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let diaryVC = storyboard.instantiateViewController(withIdentifier: "NewDiaryVC")
        self.navigationController?.pushViewController(diaryVC, animated: true)
    }
}


//MARK: tableView protocols
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryTableViewCell", for: indexPath) as? DiaryTableViewCell else { return UITableViewCell()}
        cell.dateLabel.text = diaries[indexPath.row].date
        cell.contentLabel.text = diaries[indexPath.row].content
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete,
           let id = diaries[indexPath.row].id{
            
            DataManager.shared.deleteDiary(id: id)
            diaries.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}


