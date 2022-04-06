//
//  ViewController.swift
//  DiaryApp
//
//  Created by Tuba Nur YAŞA on 5.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var notes : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notes = DataManager().getDiary()
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
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = notes[indexPath.row]
        return cell
    }
}


