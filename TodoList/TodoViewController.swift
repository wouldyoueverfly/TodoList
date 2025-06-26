//
//  TodoViewController.swift
//  TodoList
//
//  Created by Ruslan Khusainov on 26.06.2025.
//

import UIKit

protocol TodoViewControllerDelegate: AnyObject {
    func todoViewController(_ vc: TodoViewController, didSaveTodo: Todo)
}

class TodoViewController: UIViewController {
    
    var todo: Todo?

    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: TodoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = todo?.title
    }

    @IBAction func save(_ sender: Any) {
        let todo = Todo(title: textField.text!)
        delegate?.todoViewController(self, didSaveTodo: todo)
    }
}
