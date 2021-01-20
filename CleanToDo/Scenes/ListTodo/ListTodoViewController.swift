//
//  ListTodoViewController.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import UIKit

protocol ListTodoDisplayLogic {
    func displayFetchedTodos(viewModel: ListTodoModel.FetchTodos.ViewModel)
    func displayFetchedTodosError(viewModel: ListTodoModel.FetchTodos.ViewModel)
}

class ListTodoViewController: UIViewController, ListTodoDisplayLogic {
    var interactor: ListTodoBusinessLogic?
    var router: (NSObject & ListTodoRoutingLogic & ListTodoDataPassing)?
    
    @IBOutlet var todoTableView: UITableView!
    
    var displayedTodos: [ListTodoModel.FetchTodos.ViewModel.DisplayedTodo] = []
    
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
        interactor?.fetchTodos()
    }

    func displayFetchedTodos(viewModel: ListTodoModel.FetchTodos.ViewModel) {
        displayedTodos = viewModel.displayedTodos!
    }
    
    func displayFetchedTodosError(viewModel: ListTodoModel.FetchTodos.ViewModel) {
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
