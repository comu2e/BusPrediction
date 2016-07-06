//
//  StationPositoinRealm.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/07.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//

import Foundation
import RealmSwift

class StationPositoinRealm: Object {
    
        dynamic var StationName:String = ""
        var  Position = List<GPS>()
  
}

class GPS:Object{
    dynamic var lat:Float = 0.0
    dynamic var lng:Float = 0.0
}
