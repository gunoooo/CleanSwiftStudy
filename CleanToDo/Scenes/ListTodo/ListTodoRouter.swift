//
//  ListTodoRouter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import UIKit

@objc protocol ListTodoRoutingLogic {
    func routeToDetailTodo(segue: UIStoryboardSegue?)
    func routeToAddTodo(seque: UIStoryboardSegue?)
}

protocol ListTodoDataPassing {
    var dataStore: ListTodoDataStore? { get }
}

class ListTodoRouter: NSObject, ListTodoRoutingLogic, ListTodoDataPassing {
    var viewController: ListTodoViewController?
    var dataStore: ListTodoDataStore?
    
    // Routing
    
    func routeToDetailTodo(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailTodoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetailTodo(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier:   "DetailTodoViewController") as! DetailTodoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetailTodo(source: dataStore!, destination: &destinationDS)
            navigateToDetailTodo(source: viewController!, destination: destinationVC)
        }
    }
    
    func routeToAddTodo(seque: UIStoryboardSegue?) {
        
    }
    
    // Navigation
    
    private func navigateToDetailTodo(
        source: ListTodoViewController,
        destination: DetailTodoViewController
    ) {
        source.show(destination, sender: nil)
    }
    
    // Passing Data
    
    private func passDataToDetailTodo(
        source: ListTodoDataStore,
        destination: inout DetailTodoDataStore
    ) {
//        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
//        destination.todos = source.todos?[selectedRow!]
    }
}
