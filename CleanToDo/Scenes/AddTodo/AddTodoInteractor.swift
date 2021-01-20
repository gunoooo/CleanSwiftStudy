//
//  AddTodoInteractor.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import RxSwift

protocol AddTodoBusinessLogic {
    func addTodo(request: AddTodoModel.AddTodo.Request)
}

protocol AddTodoDataStore {
    var todo: Todo? { set get }
}

class AddTodoInteractor: AddTodoBusinessLogic, AddTodoDataStore {
    var presenter: AddTodoPresentationLogic?
    
    var todo: Todo?
    
    let disposeBag = DisposeBag()
    let todoWorker = TodoWorker()
    
    func addTodo(request: AddTodoModel.AddTodo.Request) {
        let todo = Todo(
            title: request.todoFormFields.title,
            contents: request.todoFormFields.contents
        )
        todoWorker.addTodo(todo: todo).subscribe(
            onSuccess: { data in
                self.todo = todo
                self.presenter?.presentAddedTodo(
                    response: AddTodoModel.AddTodo.Response(
                        successMessage: data
                    )
                )
            },
            onFailure: { error in
                self.presenter?.presentAddedTodo(
                    response: AddTodoModel.AddTodo.Response(
                        errorMessage: error.localizedDescription
                    )
                )
            }
        ).disposed(by: disposeBag)
    }
}
