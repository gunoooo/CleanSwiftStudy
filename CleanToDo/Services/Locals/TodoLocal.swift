//
//  TodoLocal.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import RxSwift

class TodoLocal: BaseLocal {
    func insertTodo(todo: Todo) -> Single<String> {
        return Single<String>.create { single in
            do {
                try self.realm.write {
                    self.realm.add(todo.toDBModel())
                }
                single(.success("TODO 목록에 추가되었습니다."))
            } catch {
                single(.failure(
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
