//
//  Model.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/05.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//
import Unbox

struct User: Unboxable {
    let name: String
    let age: Int
    let isMan: Bool
    let date: NSDate?
    
    init(unboxer: Unboxer) {
        self.name = unboxer.unbox("name")
        self.age = unboxer.unbox("age")
        self.isMan = unboxer.unbox("is_man")
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        self.date = unboxer.unbox("date", formatter: dateFormatter)
    }
}