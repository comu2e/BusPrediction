//
//  makeRealmFromJson.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/07.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//

import Foundation
import SwiftyJSON
import Unbox
import RealmSwift

func json_to_realm(BusData:NSJSONSerialization!){
    let BusData = NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)
    let json = JSON(data:NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)!)
    let realm_position = try! Realm()

    func makeUniqueStationArray() -> [String] {
        //        重複する要素を配列から取り除く関数を定義
        func returnUniqueArray(source:[AnyObject]) -> [AnyObject] {
            let set = NSOrderedSet(array: source)
            let result = set.array
            return result
        }
        
        let rbo:rosen_by_order = try! Unbox(BusData!)
        let rbo_int = rbo.rosen_by_order_Array
        
        var master_station_array:[String] = []
        //        var master_companyid_array:[Int] = []
        //         var master_expl_array:[String] = []
        //        var master_dest_array:[String] = []
        //        var master_name_array:[String] = []
        
        let rbo_string = rbo_int.map{($0).description} as [String]!
        //        let json = JSON(data:self.BusData!)
        
        //ここでunique_arrayを作る
        for i in rbo_string{
            if  json != nil{
                let stations = json["rosen"]["\(i)"]["stations"].arrayObject as! [String]
                //                let companyid = json["rosen"]["\(i)"]["companyid"].arrayObject as! [Int]
                //                let dest = json["rosen"]["\(i)"]["dest"].arrayObject as! [String]
                //                let expl = json["rosen"]["\(i)"]["expl"].arrayObject as! [String]
                //                let name = json["rosen"]["\(i)"]["name"].arrayObject as! [String]
                
                master_station_array = master_station_array + stations
                
            }
        }
        let  unique_array = returnUniqueArray(master_station_array) as! [String]
        return unique_array
    }
    //    Realmファイル作製
    func takePositionInfoFromStationName(unique_array:[String]){
        for station in unique_array{
            if json != nil {
                //                lat = 32.000,lng = 34.000など
                let lat = json["station"]["\(station)"]["lat"].float
                let lng = json["station"]["\(station)"]["lng"].float
                
                try! realm_position.write(){
                    let station_position = StationPositionRealm()
                    let gps = GPS()
                    
                    station_position.StationName = station
                    gps.lat = lat!
                    gps.lng = lng!
                    
                    // この行を追加
                    station_position.positions = gps
                    
                    realm_position.add(station_position)
                    realm_position.add(gps)
                }
                
            }
        }
        
    }
    
    
    let unique_array = makeUniqueStationArray()
    takePositionInfoFromStationName(unique_array)
    
}


