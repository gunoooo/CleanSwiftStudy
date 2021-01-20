//
//  AddTodoPresenter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation

protocol AddTodoPresentationLogic {
    func presentAddedTodo(response: AddTodoModel.AddTodo.Response)
}

class AddTodoPresenter: AddTodoPresentationLogic {
    var viewController: AddTodoDisplayLogic?
    
    func presentAddedTodo(response: AddTodoModel.AddTodo.Response) {
        if (response.errorMessage == nil) {
            displayAddedTodo(response: response)
        } else {
            displayAddedTodoError(response: response)
        }
    }
    
    private func displayAddedTodo(response: AddTodoModel.AddTodo.Response) {
        viewController?.displayAddedTodo(
            viewModel: AddTodoModel.AddTodo.ViewModel(
                successMessage: response.successMessage
            )
        )
    }
    
    private func displayAddedTodoError(response: AddTodoModel.AddTodo.Response) {
        viewController?.displayAddedTodoError(
            viewModel: AddTodoModel.AddTodo.ViewModel(
                errorMessage: response.errorMessage
            )
        )
    }
}
