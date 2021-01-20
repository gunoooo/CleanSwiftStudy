//
//  ListTodoPresenter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation

protocol ListTodoPresentationLogic {
    func presentFetchedTodos(response: ListTodoModel.FetchTodos.Response)
}

class ListTodoPresenter: ListTodoPresentationLogic {
    var viewController: ListTodoDisplayLogic?
    
    func presentFetchedTodos(response: ListTodoModel.FetchTodos.Response) {
        if (response.errorMessage == nil) {
            displayFetchedTodos(response: response)
        } else {
            displayFetchedTodosError(response: response)
        }
    }
    
    private func displayFetchedTodos(response: ListTodoModel.FetchTodos.Response) {
        viewController?.displayFetchedTodos(
            viewModel: ListTodoModel.FetchTodos.ViewModel(
                displayedTodos: response.todos!.map {
                    ListTodoModel.FetchTodos.ViewModel.DisplayedTodo(
                        title: $0.title,
                        contents: $0.contents,
                        createdDate: $0.createdDate.formatToString(dateFormat: "yyyy-MM-dd")
                    )
                }
            )
        )
    }
    
    private func displayFetchedTodosError(response: ListTodoModel.FetchTodos.Response) {
        viewController?.displayFetchedTodosError(
            viewModel: ListTodoModel.FetchTodos.ViewModel(
                errorMessage: response.errorMessage
            )
        )
    }
}
