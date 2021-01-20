//
//  DetailTodoViewController.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import UIKit

protocol DetailTodoDisplayLogic {
    func displayFetchedTodo(viewModel: DetailTodoModel.FetchTodo.ViewModel)
    func displayFetchedTodoError(viewModel: DetailTodoModel.FetchTodo.ViewModel)
}

class DetailTodoViewController: UIViewController, DetailTodoDisplayLogic {
    var interactor: DetailTodoBusinessLogic?
    var router: (NSObject & DetailTodoRoutingLogic & DetailTodoDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = DetailTodoInteractor()
        let presenter = DetailTodoPresenter()
        let router = DetailTodoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func displayFetchedTodo(viewModel: DetailTodoModel.FetchTodo.ViewModel) {
        
    }
    
    func displayFetchedTodoError(viewModel: DetailTodoModel.FetchTodo.ViewModel) {
        
    }
}
