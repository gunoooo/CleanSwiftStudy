//
//  BaseLocal.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import RealmSwift

class BaseLocal {
    private static var realmInstance : Realm!
    
    lazy var realm: Realm! = {
        if(BaseLocal.realmInstance == nil){
            BaseLocal.realmInstance = try! Realm()
        }
        return BaseLocal.realmInstance
    }()
}
