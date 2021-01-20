//
//  TodoCell.swift
//  CleanToDo
//
//  Created by Park on 2021/01/20.
//

import Foundation
import UIKit

class TodoCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var createdDateLable: UILabel!
    
    func bind(displayedTodo: ListTodoModel.FetchTodos.ViewModel.DisplayedTodo) {
        self.titleLable.text = displayedTodo.title
        self.createdDateLable.text = displayedTodo.createdDate
    }
}
