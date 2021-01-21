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
    weak var viewController: ListTodoViewController?
    
    // Data
    
    var dataStore: ListTodoDataStore?
    
    // Routing
    
    func routeToDetailTodo(segue: UIStoryboardSegue?) {
        var destinationViewController: DetailTodoViewController
        var desinationDataStore: DetailTodoDataStore
        if let segue = segue {
            destinationViewController = segue.destination as! DetailTodoViewController
            desinationDataStore = destinationViewController.router!.dataStore!
            passDataToDetailTodo(source: dataStore!, destination: &desinationDataStore)
        } else {
            let destinationViewController = viewController?.storyboard?
                .instantiateViewController(withIdentifier: "DetailTodoViewController") as! DetailTodoViewController
            var desinationDataStore = destinationViewController.router!.dataStore!
            passDataToDetailTodo(source: dataStore!, destination: &desinationDataStore)
            navigateToDetailTodo(source: viewController!, destination: destinationViewController)
        }
    }
    
    func routeToAddTodo(seque: UIStoryboardSegue?) {
        
    }
    
    // Navigation
    
    private func navigateToDetailTodo(
        source: ListTodoViewController,
        destination: DetailTodoViewController
    ) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // Passing Data
    
    private func passDataToDetailTodo(
        source: ListTodoDataStore,
        destination: inout DetailTodoDataStore
    ) {
        let selectedRow = viewController?.todoTableView.indexPathForSelectedRow?.row
        destination.todo = source.todos?[selectedRow!]
    }
}
