//
//  AllData.swift
//  TodoList
//
//  Created by Николай Черняк on 03/10/2019.
//  Copyright © 2019 Николай Черняк. All rights reserved.
//

import Foundation
import Alamofire

struct AllData: ResponseObjectSerializable, ResponseCollectionSerializable
{
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: [[String: Any]]],
            let projects = representation["projects"],
            let todos = representation["todos"]
        else { return nil }
        for project in projects{
            let currentProject = Project()
            currentProject.title = project["title"] as! String
            allProjects.append(currentProject)
        }
        for todo in todos{
            let currentTodo = Todo()
            currentTodo.text = todo["text"] as! String
            currentTodo.project_id = todo["project_id"] as? Int
            currentTodo.isCompleted = todo["isCompleted"] as! Bool
            allTodos.append(currentTodo)
        }
    }
    
    var allProjects:[Project] = []
    var allTodos:[Todo] = []
}
