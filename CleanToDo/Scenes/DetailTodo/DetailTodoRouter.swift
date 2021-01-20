//
//  DetailTodoRouter.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import UIKit

@objc protocol DetailTodoRoutingLogic {
    func routeToAddTodo(segue: UIStoryboardSegue?)
}

protocol DetailTodoDataPassing {
    var dataStore: DetailTodoDataStore? { get }
}

class DetailTodoRouter: NSObject, DetailTodoRoutingLogic, DetailTodoDataPassing {
    var viewController: DetailTodoViewController?
    var dataStore: DetailTodoDataStore?
    
    // Routing
    
    func routeToAddTodo(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! AddTodoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToAddTodo(source: dataStore!, destination: &destinationDS)
        } else {
            let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier:   "AddTodoViewController") as! AddTodoViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToAddTodo(source: dataStore!, destination: &destinationDS)
            navigateToAddTodo(source: viewController!, destination: destinationVC)
        }
    }
    
    // Navigation
    
    private func navigateToAddTodo(
        source: DetailTodoViewController,
        destination: AddTodoViewController
    ) {
        source.show(destination, sender: nil)
    }
    
    // Data Passing
    
    private func passDataToAddTodo(
        source: DetailTodoDataStore,
        destination: inout AddTodoDataStore
    ) {
        destination.todo = source.todo
    }
}
