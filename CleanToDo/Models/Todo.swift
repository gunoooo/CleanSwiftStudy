//
//  Todo.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import Foundation
import RealmSwift

struct Todo {
    var idx: Int
    var title: String
    var contents: String
    var createdDate: Date
    
    init(
        idx: Int = 0,
        title: String,
        contents: String,
        createdDate: Date = Date()
    ) { // Todo 생성 시 createdDate에 현시간 자동 입력
        self.idx = idx
        self.title = title
        self.contents = contents
        self.createdDate = createdDate
    }
}

class TodoDBModel: Object {
    @objc dynamic var idx: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var contents: String = ""
    @objc dynamic var createdDate: String = ""
    
    convenience init(
        idx: Int,
        title: String,
        contents: String,
        createdDate: String
    ) {
        self.init()
        self.idx = idx
        self.title = title
        self.contents = contents
        self.createdDate = createdDate
    }
    
    override static func primaryKey() -> String? {
        return "idx"
    }

    func setAutoIncrementIdx() {
        let realm = try! Realm()
        if let retNext = realm.objects(TodoDBModel.self).sorted(byKeyPath: "idx").first?.idx {
            self.idx = retNext + 1
        } else {
            self.idx = 1
        }
    }
}

/**
    Mapping 함수
 */
extension Todo {
    func toDBModel() -> TodoDBModel {
        return TodoDBModel(
            idx: idx,
            title: title,
            contents: contents,
            createdDate: createdDate.formatToString(dateFormat: "yyyy-MM-dd")
        )
    }
}

extension TodoDBModel {
    func toModel() -> Todo {
        return Todo(
            idx: idx,
            title: title,
            contents: contents,
            createdDate: createdDate.formatToDate(dateFormat: "yyyy-MM-dd")
        )
    }
}
