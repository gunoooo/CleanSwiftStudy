//
//  Todo.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import RealmSwift

struct Todo {
    var title: String
    var contents: String
    var createdDate: Date
    
    init(
        title: String,
        contents: String,
        createdDate: Date = Date()
    ) { // Todo 생성 시 createdDate에 현시간 자동 입력
        self.title = title
        self.contents = contents
        self.createdDate = createdDate
    }
}

class TodoDBModel: Object {
    @objc var title: String = ""
    @objc var contents: String = ""
    @objc var createdDate: String = ""
    
    convenience init(
        title: String,
        contents: String,
        createdDate: String
    ) {
        self.init()
        self.title = title
        self.contents = contents
        self.createdDate = createdDate
    }
}

/**
    Mapping 함수
 */
extension Todo {
    func toDBModel() -> TodoDBModel {
        return TodoDBModel(
            title: title,
            contents: contents,
            createdDate: createdDate.formatToString(dateFormat: "yyyy-MM-dd")
        )
    }
}

extension TodoDBModel {
    func toModel() -> Todo {
        return Todo(
            title: title,
            contents: contents,
            createdDate: createdDate.formatToDate(dateFormat: "yyyy-MM-dd")
        )
    }
}
