//
//  ViewController.swift
//  #19TODO-list[Part 1]
//
//  Created by Anastasia Bilous on 2022-03-16.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var toDoTableList: UITableView!
    
    var toDoListAllNames = [String]()
    var toDoListAllDescriptions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableList.delegate = self
        toDoTableList.dataSource = self
        addButton.layer.cornerRadius = 15
    }
    
    @IBAction func AddButtonGoNew(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "NewTaskVC") as?
        NewTaskViewController
        controller?.delegate = self
        controller?.modalPresentationStyle = .fullScreen
        navigationController?.present(controller!, animated: true, completion: nil)
    }
}
extension ToDoListViewController: NewTaskViewControllerDelegate {
    func didAddName(_ name: String) {
        toDoListAllNames.insert(name, at: 0)
        self.toDoTableList.reloadData()
    }
    
    func didAddDescription(_ description: String) {
        toDoListAllDescriptions.insert(description, at: 0)
        self.toDoTableList.reloadData()
    }
}

extension ToDoListViewController: UITableViewDelegate {
    
}

extension ToDoListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = UIFont.init(name: "Roboto-Regular", size: 18)
        cell.textLabel?.text = toDoListAllNames[indexPath.row] + ": " + toDoListAllDescriptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListAllNames.count
    }
}


