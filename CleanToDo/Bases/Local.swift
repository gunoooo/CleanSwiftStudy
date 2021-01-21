//
//  BaseLocal.swift
//  CleanToDo
//
//  Created by Park on 2021/01/19.
//

import RealmSwift

class Local {
    private static var realmInstance : Realm!
    
    lazy var realm: Realm! = {
        if(CleanToDo.Local.realmInstance == nil){
            CleanToDo.Local.realmInstance = try! Realm()
        }
        return CleanToDo.Local.realmInstance
    }()
}
