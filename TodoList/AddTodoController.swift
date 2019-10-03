//
//  AddTodoController.swift
//  TodoList
//
//  Created by Николай Черняк on 30/09/2019.
//  Copyright © 2019 Николай Черняк. All rights reserved.
//

import UIKit
import Alamofire

class AddTodoController:UIViewController,UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var AddTodoTable: UITableView!
    var todoController: TodoController?
    var selectedProject :Int?
    var textOfNewTodo = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (projectTitles.count + 1)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewCell()
        header.textLabel?.text = "Новая задача:"
        header.backgroundColor = UIColor.opaqueSeparator
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddTodoText") as! TodoTextCell
            cell.todoText = {value in self.textOfNewTodo = value}
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsList", for: indexPath)
            cell.textLabel?.text = projectTitles[(indexPath.row-1)]
            cell.tintColor = UIColor.gray
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40

    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 200
        default:
            return 50
        }
        

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if (cell?.selectionStyle != UITableViewCell.SelectionStyle.none){
            cell?.accessoryType = .checkmark
            selectedProject = (indexPath.row - 1)
        }
    }
    
    func tableView(_ tableView: UITableView,didDeselectRowAt  indexPath: IndexPath) {
           let cell = tableView.cellForRow(at: indexPath)
           
           cell?.accessoryType = .none
           }
    
    var projectTitles = [String]()
    
    @IBAction func onBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func onSaveButton(_ sender: Any) {
        if !(textOfNewTodo == "") && selectedProject != nil {
        dismiss(animated: true,completion: {
            let  parameters: [String: [String: Any]] = [
                "todo": [
                    "ios": true,
                    "text": self.textOfNewTodo,
                    "project_id": self.selectedProject! + 1
                ]
            ]
            Alamofire.request("https://obscure-harbor-43101.herokuapp.com/todos",method: .post, parameters: parameters)
            self.todoController?.OnUserAction()
        })
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AddTodoTable.delegate = self
        AddTodoTable.dataSource = self
    }
}
