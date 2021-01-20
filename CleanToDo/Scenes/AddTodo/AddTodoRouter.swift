//
//  AddTodoRouter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import UIKit

@objc protocol AddTodoRoutingLogic {
    func routeToListTodo(segue: UIStoryboardSegue?)
}

protocol AddTodoDataPassing {
    var dataStore: AddTodoDataStore? { get }
}

class AddTodoRouter: NSObject, AddTodoRoutingLogic, AddTodoDataPassing {
    var viewController: AddTodoViewController?
    var dataStore: AddTodoDataStore?
    
    // Routing
    
    func routeToListTodo(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ListTodoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToListTodo(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier:   "ListTodoViewController") as! ListTodoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToListTodo(source: dataStore!, destination: &destinationDS)
            navigateToListTodo(source: viewController!, destination: destinationVC)
        }
    }
    
    // Navigation
    
    private func navigateToListTodo(
        source: AddTodoViewController,
        destination: ListTodoViewController
    ) {
        source.navigationController?.popViewController(animated: true)
    }
    
    // Passing Data
    
    private func passDataToListTodo(
        source: AddTodoDataStore,
        destination: inout ListTodoDataStore
    ) {
        if (source.todo != nil) {
            destination.todos?.append(source.todo!)
        }
    }
}
