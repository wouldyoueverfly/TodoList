//
//  ViewController.swift
//  TodoList
//
//  Created by Ruslan Khusainov on 23.06.2025.
//

import UIKit

class ViewController: UIViewController {

    let todos = [
        Todo(title: "Apply for iOS Dev job"),
        Todo(title: "Buy PC and PS5 Pro"),
        Todo(title: "Rent appartement"),
        Todo(title: "Play games with friend")
    ]
    
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
        let todo = todos[indexPath.row]
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = todo.title
        
        return cell
    }
}
