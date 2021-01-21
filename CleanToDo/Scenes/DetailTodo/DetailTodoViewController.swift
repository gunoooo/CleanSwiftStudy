//
//  DetailTodoViewController.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import UIKit

protocol DetailTodoDisplayLogic: class {
    func displayFetchedTodo(viewModel: DetailTodoModel.FetchTodo.ViewModel)
    func displayFetchedTodoError(viewModel: DetailTodoModel.FetchTodo.ViewModel)
}

class DetailTodoViewController: CleanToDo.ViewController, SetupLogic, DetailTodoDisplayLogic {
    var interactor: DetailTodoBusinessLogic?
    var router: (NSObject & DetailTodoRoutingLogic & DetailTodoDataPassing)?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    // 의존성 주입
    
    func setup() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchTodo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    func displayFetchedTodo(viewModel: DetailTodoModel.FetchTodo.ViewModel) {
        titleLabel.text = viewModel.displayedTodo!.title
        contentsLabel.text = viewModel.displayedTodo!.contents
    }
    
    func displayFetchedTodoError(viewModel: DetailTodoModel.FetchTodo.ViewModel) {
        displayErrorMessage(errorMessage: viewModel.errorMessage!)
    }
}
