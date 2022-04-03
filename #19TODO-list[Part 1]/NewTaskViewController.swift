//
//  NewTaskViewController.swift
//  #19TODO-list[Part 1]
//
//  Created by Anastasia Bilous on 2022-03-16.
//

import UIKit

protocol NewTaskViewControllerDelegate: AnyObject{
    func didAddName(_ name: String)
    func didAddDescription(_ description: String)
}

class NewTaskViewController: UIViewController {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskDesriptionField: UITextField!
    
    weak var delegate: NewTaskViewControllerDelegate?
    
    var nameAdd = String()
    var descriptionAdd = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 20
        changeLook(name: taskNameField)
        changeLook(name: taskDesriptionField)
    }
    
    func changeLook(name: UITextField) {
        name.borderStyle = .none
        name.layer.cornerRadius = 10
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.black.withAlphaComponent(0.75).cgColor
        name.layer.shadowOpacity = 1
        name.layer.shadowRadius = 2.0
        name.layer.shadowOffset = CGSize.init(width: 0, height: 3)
        name.layer.shadowColor = UIColor.gray.cgColor
        name.leftView = UIView(frame: CGRect(x: 0,
                                             y: 0,
                                             width: 10,
                                             height: name.frame.height))
        name.leftViewMode = .always
    }
    
    func warningMessage(name: String) {
        let alertVc = UIAlertController(
            title: nil,
            message: name,
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style: .default)
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel) { UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
        alertVc.addAction(okAction)
        alertVc.addAction(cancelAction)
        alertVc.preferredAction = okAction
        alertVc.view.tintColor = UIColor.white
        alertVc.setValue(NSAttributedString(
            string: alertVc.message!,
            attributes: [NSAttributedString.Key.font: UIFont.init(name: "Roboto-Regular",size: 18)!,
                         NSAttributedString.Key.foregroundColor:UIColor.white]),
                         forKey: "attributedMessage")
        alertVc.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.gray
        present(alertVc, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        nameAdd = taskNameField.text ?? ""
        descriptionAdd = taskDesriptionField.text ?? ""
        
        if nameAdd.isEmpty && descriptionAdd.isEmpty {
            warningMessage(name: "Please enter ”Name” and \n ”Description” of a new task")
            return
        } else if nameAdd.isEmpty {
            warningMessage(name: "Please enter ”Name” of a new task")
            return
        } else if descriptionAdd.isEmpty {
            warningMessage(name: "Please enter ”Description” of a new task")
            return
        }
        delegate?.didAddName(nameAdd)
        delegate?.didAddDescription(descriptionAdd)
        dismiss(animated: true, completion: nil)
    }
}

