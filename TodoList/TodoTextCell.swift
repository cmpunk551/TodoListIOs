//
//  TodoTextCell.swift
//  TodoList
//
//  Created by Николай Черняк on 30/09/2019.
//  Copyright © 2019 Николай Черняк. All rights reserved.
//

import UIKit

class TodoTextCell :UITableViewCell, UITextFieldDelegate
{
    
    @IBOutlet weak var TodoTextField: UITextField!
    var todoText: (( _ value: String)->())?
    override func awakeFromNib(){
        super.awakeFromNib()
        TodoTextField.delegate = self
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        todoText?(TodoTextField.text ?? "")
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        todoText?(TodoTextField.text ?? "")
        return true
    }
}
