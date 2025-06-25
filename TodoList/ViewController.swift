//
//  ViewController.swift
//  TodoList
//
//  Created by Ruslan Khusainov on 23.06.2025.
//

import UIKit

class ViewController: UIViewController {

    var todos = [
        Todo(title: "Apply for iOS Dev job"),
        Todo(title: "Buy PC and PS5 Pro"),
        Todo(title: "Rent appartement"),
        Todo(title: "Play games with friend")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        cell.delegate = self
        
        let todo = todos[indexPath.row]
        
        cell.set(title: todo.title, checked: todo.isCompleted)
        
        return cell
    }
}

extension ViewController: CheckTableViewCellDelegate {
    
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeChecked checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let todo = todos[indexPath.row]
        let newTodo = Todo(title: todo.title, isCompleted: todo.isCompleted)
        
        todos[indexPath.row] = newTodo
        
        
    }
}
