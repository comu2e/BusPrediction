//
//  Model.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/05.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//
import RealmSwift
import Unbox
//Rosen用のRealm
class Rosen:Object {
    
    dynamic var id = 0
//idにrosen_by_orderの番号をいれておく
    dynamic var expl = ""
    dynamic var dest = ""
    dynamic var companyid = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
class StationsList:Object{
    let list = List<Rosen>()
}