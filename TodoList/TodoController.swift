//
//  ViewController.swift
//  TodoList
//
//  Created by Николай Черняк on 28/09/2019.
//  Copyright © 2019 Николай Черняк. All rights reserved.
//

import UIKit
import M13Checkbox
import Alamofire

class TodoController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var projects = [Project]()
    var todos = [Todo]()
    @IBOutlet weak var projectsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectsTable.delegate = self
        projectsTable.dataSource = self
        Alamofire.request("https://obscure-harbor-43101.herokuapp.com/todos.json").responseObject { (response: DataResponse<AllData>) in
            debugPrint(response)
            if let allData = response.result.value {
                self.projects = allData.allProjects
                self.todos = allData.allTodos
                self.projectsTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todos.filter({todo in todo.project_id == (section+1)}).count
       }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "Project")
        header?.textLabel?.text = projects[section].title
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let todo = todos.filter({todo in todo.project_id == (indexPath.section+1)})[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo",for: indexPath) as! TodoCell
        
        var todoId: Int = 0
        for currentTodo in todos.reversed(){
            if currentTodo === todo{
                cell.todoId = todoId + 1
            }
            else{
                todoId += 1
            }
        }
        cell.TodoText.text = todo.text
        if todo.isCompleted{
            cell.checkbox.setCheckState(.checked, animated: false)
            cell.strikeThrough()
        }
        else{
            cell.checkbox.setCheckState(.unchecked, animated: false)
            cell.strikeThrough()
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return projects.count
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
       if let navVc = segue.destination as? UINavigationController,
        let addTodoVc = navVc.topViewController as? AddTodoController {
        addTodoVc.todoController = self
            for project in projects{
                addTodoVc.projectTitles.append(project.title)
            }
            
        }
    }
    func OnUserAction(){
        Alamofire.request("https://obscure-harbor-43101.herokuapp.com/todos.json").responseObject { (response: DataResponse<AllData>) in
        debugPrint(response)
        if let allData = response.result.value {
            self.projects = allData.allProjects
            self.todos = allData.allTodos
            self.projectsTable.reloadData()
        }
    }
    }
    
    func GetDataFromApi(){
        
    }
    
}

