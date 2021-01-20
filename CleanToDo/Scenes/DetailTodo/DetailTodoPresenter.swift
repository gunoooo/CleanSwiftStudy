//
//  DetailTodoPresenter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation

protocol DetailTodoPresentationLogic {
    func presentFetchedTodo(response: DetailTodoModel.FetchTodo.Response)
}

class DetailTodoPresenter: DetailTodoPresentationLogic {
    var viewController: DetailTodoDisplayLogic?
    
    func presentFetchedTodo(response: DetailTodoModel.FetchTodo.Response) {
        if (response.errorMessage == nil) {
            displayFetchedTodo(response: response)
        } else {
            displayFetchedTodoError(response: response)
        }
    }
    
    private func displayFetchedTodo(response: DetailTodoModel.FetchTodo.Response) {
        viewController?.displayFetchedTodo(
            viewModel: DetailTodoModel.FetchTodo.ViewModel(
                displayedTodo: DetailTodoModel.FetchTodo.ViewModel.DisplayedTodo(
                    title: response.todo!.title,
                    contents: response.todo!.contents,
                    createdDate: response.todo!.createdDate.formatToString(dateFormat: "yyyy-MM-dd")
                )
            )
        )
    }
    
    private func displayFetchedTodoError(response: DetailTodoModel.FetchTodo.Response) {
        viewController?.displayFetchedTodo(
            viewModel: DetailTodoModel.FetchTodo.ViewModel(
                errorMessage: response.errorMessage
            )
        )
    }
}
