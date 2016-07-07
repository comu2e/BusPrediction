//
//  StationPositoinRealm.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/07.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//

import Foundation
import RealmSwift



class GPS:Object{
    dynamic var lat:Float = 0.0
    dynamic var lng:Float = 0.0
    let gpses = LinkingObjects(fromType: StationPositionRealm.self, property: "positions")
}

class StationPositionRealm: Object {
    dynamic var StationName:String = ""
    dynamic var positions:GPS?
    
}

