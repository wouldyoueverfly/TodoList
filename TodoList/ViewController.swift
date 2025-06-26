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

    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing.toggle()
    }
    
    @IBSegueAction func plusButtonSegue(_ coder: NSCoder) -> TodoViewController? {
        let vc = TodoViewController(coder: coder)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let todo = todos[indexPath.row]
            vc?.todo = todo
        }
        
        vc?.delegate = self
        vc?.presentationController?.delegate
        
        return vc
    }
    @IBSegueAction func todoViewController(_ coder: NSCoder) -> TodoViewController? {
        let vc = TodoViewController(coder: coder)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let todo = todos[indexPath.row]
            vc?.todo = todo
        }
        
        vc?.delegate = self
        vc?.presentationController?.delegate = self
        
        return vc
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete") { action, view, completed in
            let todo = self.todos[indexPath.row].completeToggled()
            self.todos[indexPath.row] = todo
            
            let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            cell.set(checked: todo.isCompleted)
            
            completed(true)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
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

extension ViewController: TodoViewControllerDelegate {
    func todoViewController(_ vc: TodoViewController, didSaveTodo: Todo) {
        dismiss(animated: true) {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.todos[indexPath.row] = didSaveTodo
                self.tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                self.todos.append(didSaveTodo)
                self.tableView.reloadData()
            }
        }
        
    }
}

extension ViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
