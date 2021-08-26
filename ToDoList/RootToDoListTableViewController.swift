//
//  ViewController.swift
//  ToDoList
//
//  Created by user on 26.08.2021.
//

import UIKit

class RootToDoListTableViewController: UITableViewController {

    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }

    @objc func addTask() {
        let ac = UIAlertController(title: "Новая задача", message: "Введите новую задачу", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Добавть задачу", style: .default) { [weak self] _ in
            guard let text = ac.textFields![0].text else { return }
            let task = KernelTask(name: text)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Task") else { return UITableViewCell() }
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.detailTextLabel?.text = "Подзадачи: \(tasks[indexPath.row].countOfSubTasks)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTaskVC") as! DetailTaskViewController
        vc.currentTask = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

