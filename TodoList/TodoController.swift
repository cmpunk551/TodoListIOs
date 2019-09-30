//
//  ViewController.swift
//  TodoList
//
//  Created by Николай Черняк on 28/09/2019.
//  Copyright © 2019 Николай Черняк. All rights reserved.
//

import UIKit

class TodoController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    struct Project {
        var todos = [String]()
        var name :String
    }
    
    var projects = [Project]()
    
    @IBOutlet weak var projectsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectsTable.delegate = self
        projectsTable.dataSource = self
        
        let firstProject = Project(todos: ["Приготовить обед","Погулять с собакой","Убраться"], name:"Семья")
       
        projects.append(firstProject)
        
        let secondProject = Project(todos:["Сделать Отчёт","Совещание"], name: "Работа")
        projects.append(secondProject)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return projects[section].todos.count
       }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "Project")
        header?.textLabel?.text = projects[section].name
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todo",for: indexPath) as! TodoCell
        cell.TodoText.text = projects[indexPath.section].todos[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return projects.count
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
       if let navVC = segue.destination as? UINavigationController,
        let addTodovc = navVC.topViewController as? AddTodoController {
        addTodovc.todoController = self
            for project in projects{
                addTodovc.projectTitles.append(project.name)
            }
            
        }
    }
    func OnUserAction(project: Int, todoName: String){
        projects[project].todos.append(todoName)
        projectsTable.reloadData()
    }
}

