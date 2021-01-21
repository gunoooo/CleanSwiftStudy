//
//  ListTodoViewController.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import UIKit

protocol ListTodoDisplayLogic: class {
    func displayFetchedTodos(viewModel: ListTodoModel.FetchTodos.ViewModel)
    func displayFetchedTodosError(viewModel: ListTodoModel.FetchTodos.ViewModel)
}

class ListTodoViewController: CleanToDo.ViewController, SetupLogic, ListTodoDisplayLogic {
    var interactor: ListTodoBusinessLogic?
    var router: (NSObject & ListTodoRoutingLogic & ListTodoDataPassing)?
    
    @IBOutlet var todoTableView: UITableView!
    
    var displayedTodos: [ListTodoModel.FetchTodos.ViewModel.DisplayedTodo] = []
    
    func setup() {
        let viewController = self
        let interactor = ListTodoInteractor()
        let presenter = ListTodoPresenter()
        let router = ListTodoRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchTodos()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    func displayFetchedTodos(viewModel: ListTodoModel.FetchTodos.ViewModel) {
        displayedTodos = viewModel.displayedTodos!
        todoTableView.reloadData()
    }
    
    func displayFetchedTodosError(viewModel: ListTodoModel.FetchTodos.ViewModel) {
        displayErrorMessage(errorMessage: viewModel.errorMessage!)
    }
}

extension ListTodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedTodos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        cell.bind(displayedTodo: displayedTodos[indexPath.row])
        return cell
    }
}
