//
//  TodoLocal.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import RxSwift

class TodoWorker {
    private var local = TodoLocal()
    
    func addTodo(todo: Todo) -> Single<String> {
        return local.insertTodo(todo: todo)
    }
    
    func modifyTodo(todo: Todo) -> Single<String> {
        return local.updateTodo(todo: todo)
    }
    
    func fetchTodos() -> Single<[Todo]> {
        return local.selectTodoList()
    }
}
