//
//  ListTodoInteractor.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import RxSwift

protocol ListTodoBusinessLogic {
    func fetchTodos()
}

protocol ListTodoDataStore {
    var todos: [Todo]? { set get }
}

class ListTodoInteractor: ListTodoBusinessLogic, ListTodoDataStore {
    var presenter: ListTodoPresentationLogic?
    
    var todos: [Todo]?
    
    let disposeBag = DisposeBag()
    let todoWorker = TodoWorker()
    
    func fetchTodos() {
        todoWorker.fetchTodos().subscribe(
            onSuccess: { data in
                self.todos = data
                self.presentFetchedTodos()
            },
            onFailure: { error in
                self.presentFetchedTodos(error: error)
            }
        ).disposed(by: disposeBag)
    }
    
    private func presentFetchedTodos() {
        presenter?.presentFetchedTodos(
            response: ListTodoModel.FetchTodos.Response(
                todos: todos
            )
        )
    }
    
    private func presentFetchedTodos(error: Error) {
        presenter?.presentFetchedTodos(
            response: ListTodoModel.FetchTodos.Response(
                errorMessage: (error as! TDError).errorMessage
            )
        )
    }
}
