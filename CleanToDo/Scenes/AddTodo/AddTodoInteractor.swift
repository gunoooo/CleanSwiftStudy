//
//  AddTodoInteractor.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import RxSwift

protocol AddTodoBusinessLogic {
    func addTodo(request: AddTodoModel.AddTodo.Request)
    func modifyTodo(request: AddTodoModel.ModifyTodo.Request)
    func fetchTodo()
}

protocol AddTodoDataStore {
    var todo: Todo? { set get }
}

class AddTodoInteractor: AddTodoBusinessLogic, AddTodoDataStore {
    var presenter: AddTodoPresentationLogic?
    
    var todo: Todo?
    
    private let disposeBag = DisposeBag()
    private let todoWorker = TodoWorker()
    
    func addTodo(request: AddTodoModel.AddTodo.Request) {
        if (todo != nil) {
            modifyTodo(request:
                AddTodoModel.ModifyTodo.Request(
                    idx: todo!.idx,
                    todoFormFields: request.todoFormFields
                )
            )
        } else {
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
                            errorMessage: (error as! TDError).errorMessage
                        )
                    )
                }
            ).disposed(by: disposeBag)
        }
    }
    
    func modifyTodo(request: AddTodoModel.ModifyTodo.Request) {
        let todo = Todo(
            idx: self.todo!.idx,
            title: request.todoFormFields.title,
            contents: request.todoFormFields.contents,
            createdDate: self.todo!.createdDate
        )
        todoWorker.modifyTodo(todo: todo).subscribe(
            onSuccess: { data in
                self.todo = todo
                self.presenter?.presentModifiedTodo(
                    response: AddTodoModel.ModifyTodo.Response(
                        successMessage: data
                    )
                )
            },
            onFailure: { error in
                self.presenter?.presentModifiedTodo(
                    response: AddTodoModel.ModifyTodo.Response(
                        errorMessage: (error as! TDError).errorMessage
                    )
                )
            }
        ).disposed(by: disposeBag)
    }
    
    func fetchTodo() {
        if (todo != nil) {
            presenter?.presentFetchedTodo(
                response: AddTodoModel.FetchTodo.Response(
                    todo: todo
                )
            )
        } else {
            presenter?.presentFetchedTodo(
                response: AddTodoModel.FetchTodo.Response(
                    errorMessage: "로딩중 오류가 발생하였습니다"
                )
            )
        }
    }
}
