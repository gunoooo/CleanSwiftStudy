//
//  DetailTodoInteractor.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import RxSwift

protocol DetailTodoBusinessLogic {
    func fetchTodo()
}

protocol DetailTodoDataStore {
    var todo: Todo? { set get }
}

class DetailTodoInteractor: DetailTodoBusinessLogic, DetailTodoDataStore {
    var presenter: DetailTodoPresentationLogic?
    
    var todo: Todo?
    
    var disposeBag = DisposeBag()
    var todoWorker = TodoWorker()
    
    func fetchTodo() {
        if (todo != nil) {
            presenter?.presentFetchedTodo(
                response: DetailTodoModel.FetchTodo.Response(
                    todo: todo
                )
            )
        } else {
            presenter?.presentFetchedTodo(
                response: DetailTodoModel.FetchTodo.Response(
                    errorMessage: "로딩중 오류가 발생하였습니다"
                )
            )
        }
    }
}
