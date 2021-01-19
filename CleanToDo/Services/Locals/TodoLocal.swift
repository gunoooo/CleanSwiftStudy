//
//  TodoLocal.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import RxSwift

class TodoLocal: BaseLocal {
    func insertTodo(todo: Todo) -> Completable {
        return Completable.create { completable in
            do {
                try self.realm.write {
                    self.realm.add(todo.toDBModel())
                }
                completable(.completed)
            } catch {
                completable(.error(
                                TDError(errorMessage: "저장에 실패했습니다")))
            }
            return Disposables.create()
        }
    }
    
    func selectTodoList() -> Single<[Todo]> {
        return Single<[Todo]>.create { single in
            let data = self.realm.objects(TodoDBModel.self)
            if (data.isEmpty) {
                single(.failure(
                        TDError(errorMessage: "TODO 목록이 비어있습니다")))
            } else {
                single(.success(
                        data.map { $0.toModel() }))
            }
            return Disposables.create()
        }
    }
}
