//
//  DetailTodoModel.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation

enum DetailTodoModel {
    enum FetchTodo {
        struct Response {
            var todo: Todo?
            var errorMessage: String?
        }
        struct ViewModel {
            struct DisplayedTodo {
                var title: String
                var contents: String
                var createdDate: String
            }
            var displayedTodo: DisplayedTodo?
            var errorMessage: String?
        }
    }
}
