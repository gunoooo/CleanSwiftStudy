//
//  AddTodoPresenter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation

protocol AddTodoPresentationLogic {
    func presentAddedTodo(response: AddTodoModel.AddTodo.Response)
    func presentModifiedTodo(response: AddTodoModel.ModifyTodo.Response)
    func presentFetchedTodo(response: AddTodoModel.FetchTodo.Response)
}

class AddTodoPresenter: AddTodoPresentationLogic {
    weak var viewController: AddTodoDisplayLogic?
    
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
    
    func presentModifiedTodo(response: AddTodoModel.ModifyTodo.Response) {
        if (response.errorMessage == nil) {
            displayModifiedTodo(response: response)
        } else {
            displayModifiedTodoError(response: response)
        }
    }
    
    private func displayModifiedTodo(response: AddTodoModel.ModifyTodo.Response) {
        viewController?.displayModifiedTodo(
            viewModel: AddTodoModel.ModifyTodo.ViewModel(
                successMessage: response.successMessage
            )
        )
    }
    
    private func displayModifiedTodoError(response: AddTodoModel.ModifyTodo.Response) {
        viewController?.displayModifiedTodoError(
            viewModel: AddTodoModel.ModifyTodo.ViewModel(
                errorMessage: response.errorMessage
            )
        )
    }
    
    func presentFetchedTodo(response: AddTodoModel.FetchTodo.Response) {
        if (response.errorMessage == nil) {
            displayFetchedTodo(response: response)
        } else {
            displayFetchedTodoError(response: response)
        }
    }
    
    private func displayFetchedTodo(response: AddTodoModel.FetchTodo.Response) {
        viewController?.displayedFetchedTodo(
            viewModel: AddTodoModel.FetchTodo.ViewModel(
                displayedTodo: AddTodoModel.FetchTodo.ViewModel.DisplayedTodo(
                    title: response.todo!.title,
                    contents: response.todo!.contents
                )
            )
        )
    }
    
    private func displayFetchedTodoError(response: AddTodoModel.FetchTodo.Response) {
        viewController?.displayedFetchedTodoError(
            viewModel: AddTodoModel.FetchTodo.ViewModel(
                errorMessage: response.errorMessage
            )
        )
    }
}
