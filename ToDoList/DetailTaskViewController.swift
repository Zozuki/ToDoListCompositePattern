//
//  DetailTaskViewController.swift
//  ToDoList
//
//  Created by user on 26.08.2021.
//

import UIKit

class DetailTaskViewController: UIViewController {

    var currentTask: Task?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTaskLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        currentTaskLabel.text = currentTask?.name
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
     }

     @objc func addTask() {
         let ac = UIAlertController(title: "Новая подзадача", message: "Введите новую подзадачу", preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "Добавть задачу", style: .default) { [weak self] _ in
             guard let text = ac.textFields![0].text else { return }
             self?.currentTask?.addSubTask(taskName: text)
             self?.tableView.reloadData()
         })
         ac.addTextField()
         ac.addAction(UIAlertAction(title: "Отмена", style: .cancel))
         present(ac, animated: true)
     }
    

}

// MARK: TableView

extension DetailTaskViewController: UITableViewDataSource, UITableViewDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentTask = currentTask else { return 0 }
        return currentTask.countOfSubTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubTask") else { return UITableViewCell() }
        guard let currentTask = currentTask else { return UITableViewCell() }
        
        cell.textLabel?.text = currentTask.subTasks[indexPath.row].name
        cell.detailTextLabel?.text = "Подзадачи: \(currentTask.subTasks[indexPath.row].countOfSubTasks)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailTaskVC") as! DetailTaskViewController
        guard let currentTask = currentTask else { return }
        vc.currentTask = currentTask.subTasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
