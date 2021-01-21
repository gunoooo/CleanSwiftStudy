//
//  AddTodoModel.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation

enum AddTodoModel {
    struct TodoFormFields {
        var title: String
        var contents: String
    }
    enum AddTodo {
        struct Request {
            var todoFormFields: TodoFormFields
        }
        struct Response {
            var successMessage: String?
            var errorMessage: String?
        }
        struct ViewModel {
            var successMessage: String?
            var errorMessage: String?
        }
    }
    enum ModifyTodo {
        struct Request {
            var idx: Int
            var todoFormFields: TodoFormFields
        }
        struct Response {
            var successMessage: String?
            var errorMessage: String?
        }
        struct ViewModel {
            var successMessage: String?
            var errorMessage: String?
        }
    }
    enum FetchTodo {
        struct Response {
            var todo: Todo?
        }
        struct ViewModel {
            struct DisplayedTodo {
                var title: String
                var contents: String
            }
            var displayedTodo: DisplayedTodo?
        }
    }
}
