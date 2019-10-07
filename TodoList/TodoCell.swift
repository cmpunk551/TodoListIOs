//
//  TodoCell.swift
//  TodoList
//
//  Created by Николай Черняк on 29/09/2019.
//  Copyright © 2019 Николай Черняк. All rights reserved.
//

import UIKit
import M13Checkbox
import Alamofire

class TodoCell: UITableViewCell
{
  
    
    @IBOutlet weak var TodoText: UILabel!
    
    var todo = Todo()
    var todoId: Int = 0
    var todoText = ""
    var checkbox = M13Checkbox(frame: CGRect(x: 30.0, y: 10.0, width: 20.0, height: 20.0))
    
   override func awakeFromNib(){
    super.awakeFromNib()
    
    checkbox.boxType = M13Checkbox.BoxType.square
    checkbox.stateChangeAnimation = M13Checkbox.Animation.fill
    checkbox.addTarget(self, action: #selector(strikeThrough), for: UIControl.Event.valueChanged)
    checkbox.addTarget(self, action: #selector(UpdateState), for: UIControl.Event.valueChanged)
    contentView.addSubview(checkbox)
    TodoText.text = todoText
    TodoText.numberOfLines = 2
    }
    
    @objc func UpdateState(){
        let  parameters: [String: Int] = [
            "id": todoId
        ]
        
        Alamofire.request("https://obscure-harbor-43101.herokuapp.com/todos/" + String(todoId) ,method: .put, parameters: parameters)
        self.todo.isCompleted = !todo.isCompleted
        
    }
    @objc func strikeThrough() {
        
        if(self.checkbox.checkState == M13Checkbox.CheckState.checked){
        let strokeEffect: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor: UIColor.black]
            self.TodoText.attributedText = NSAttributedString(string: self.TodoText.text ?? "", attributes: strokeEffect)
        }
        else{
            let strokeEffect: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor: UIColor.clear]
            self.TodoText.attributedText = NSAttributedString(string: self.TodoText.text ?? "", attributes: strokeEffect)
        }
    }
}
