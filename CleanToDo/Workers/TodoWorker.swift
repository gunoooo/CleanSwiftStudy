//
//  TodoLocal.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import RxSwift

class TodoWorker {
    private var local = TodoLocal()
    
    func addTodo(todo: Todo) -> Completable {
        return local.insertTodo(todo: todo)
    }
    
    func fetchTodoList() -> Single<[Todo]> {
        return local.selectTodoList()
    }
}
