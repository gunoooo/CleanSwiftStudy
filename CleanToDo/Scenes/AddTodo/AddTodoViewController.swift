//
//  AddTodoViewController.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import UIKit

protocol AddTodoDisplayLogic {
    func displayAddedTodo(viewModel: AddTodoModel.AddTodo.ViewModel)
    func displayAddedTodoError(viewModel: AddTodoModel.AddTodo.ViewModel)
}

class AddTodoViewController: UIViewController, AddTodoDisplayLogic {
    var interactor: AddTodoBusinessLogic?
    var router: (NSObject & AddTodoRoutingLogic & AddTodoDataPassing)?
    
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
        let interactor = AddTodoInteractor()
        let presenter = AddTodoPresenter()
        let router = AddTodoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func displayAddedTodo(viewModel: AddTodoModel.AddTodo.ViewModel) {
        
    }
    
    func displayAddedTodoError(viewModel: AddTodoModel.AddTodo.ViewModel) {
        
    }
}
