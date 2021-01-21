//
//  DetailTodoRouter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import UIKit

@objc protocol DetailTodoRoutingLogic {
    func routeToModifyTodo(segue: UIStoryboardSegue?)
}

protocol DetailTodoDataPassing {
    var dataStore: DetailTodoDataStore? { get }
}

class DetailTodoRouter: NSObject, DetailTodoRoutingLogic, DetailTodoDataPassing {
    weak var viewController: DetailTodoViewController?
    
    // Data
    
    var dataStore: DetailTodoDataStore?
    
    // Routing
    
    func routeToModifyTodo(segue: UIStoryboardSegue?) {
        var destinationViewController: AddTodoViewController
        var desinationDataStore: AddTodoDataStore
        if let segue = segue {
            destinationViewController = segue.destination as! AddTodoViewController
            desinationDataStore = destinationViewController.router!.dataStore!
            passDataToModifyTodo(source: dataStore!, destination: &desinationDataStore)
        } else {
            let destinationViewController = viewController?.storyboard?
                .instantiateViewController(withIdentifier: "AddTodoViewController") as! AddTodoViewController
            var desinationDataStore = destinationViewController.router!.dataStore!
            passDataToModifyTodo(source: dataStore!, destination: &desinationDataStore)
            navigateToModifyTodo(source: viewController!, destination: destinationViewController)
        }
    }
    
    // Navigation
    
    private func navigateToModifyTodo(
        source: DetailTodoViewController,
        destination: AddTodoViewController
    ) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // Data Passing
    
    private func passDataToModifyTodo(
        source: DetailTodoDataStore,
        destination: inout AddTodoDataStore
    ) {
        destination.todo = source.todo
    }
}
