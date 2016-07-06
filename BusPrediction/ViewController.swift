//
//  ViewController.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/04.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//
//        ここにすべてのバス停情報をいれていく
//        後にここから重複すvar要素をはぶき，unique_arrayとしてかえす
//      rboの要素をクロージャーを使って文字列化
//       事前に必要なかたちに直しておく
//        JSON自体が辞書型
//        最初から加工しておく
//        加工する部分をアプリでつくっておく
//        バスとバス停をわけてそれをつなげる．
//
//        バスのモデル
//        時刻のモデル（どのバスが）
//        バス停のモデル
//        路線のモデル
//        複数のDBを結合
//

import UIKit
import RealmSwift
import Unbox
import SwiftyJSON
import ObjectMapper
class ViewController: UIViewController {
    
    let BusData = NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)
    let json = JSON(data:NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)!)

    //    各路線rosen_byorder要素ごとにおける駅名配列辞書
    var dictionary_rosen:NSDictionary!
    
    //    var rosen = try! Realm().objects(Rosen)
    
    //    var stationlist:StationsList!
    
    let realm_position = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        Jsonファイルの読み込み
        let unique_array = makeUniqueStationArray()
        takePositionInfoFromStationName(unique_array)
        //        realmに書き込み次回起動時はこのDBから読み出す
        //        realmがあるときは現在地を取得
        //        現在地を取得して近くのバス停をピン付する
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func makeUniqueStationArray() -> [String] {
//        重複する要素を配列から取り除く関数を定義
        func returnUniqueArray(source:[AnyObject]) -> [AnyObject] {
            let set = NSOrderedSet(array: source)
            let result = set.array as! [String]
            return result
        }
        
        let rbo:rosen_by_order = try! Unbox(self.BusData!)
        let rbo_int = rbo.rosen_by_order_Array
        
        var master_station_array:[String] = []
        
        let rbo_string = rbo_int.map{($0).description} as [String]!
//        let json = JSON(data:self.BusData!)
//ここでunique_arrayを作る
        for i in rbo_string{
            if  self.json != nil{
                let stations = self.json["rosen"]["\(i)"]["stations"].arrayObject as! [String]
                //                let companyid = json["rosen"]["\(i)"]["companyid"].int
                //                let dest = json["rosen"]["\(i)"]["dest"].string
                //                let expl = json["rosen"]["\(i)"]["expl"].string
                //                let name = json["rosen"]["\(i)"]["name"].string
                //
                master_station_array = master_station_array + stations
            }
        }
        let  unique_array = returnUniqueArray(master_station_array) as! [String]
        return unique_array
    }
    func takePositionInfoFromStationName(unique_array:[String]){
        var position_with_stationname:[String:[Float?]] = [:]
        for station in unique_array{
            if self.json != nil {
                var lat = self.json["station"]["\(station)"]["lat"].float
                var lng = self.json["station"]["\(station)"]["lng"].float
                var position = [lat,lng]
//                position_with_stationname.updateValue(position, forKey: station)
//                
                try! self.realm_position.write(){
                    let station_position = StationPositoinRealm()
                    let gps = GPS()
                    let position_realm = [gps.lat,gps.lng]
                    station_position.StationName = station
                    station_position.Position.append(position)
                    
                    realm_position.add(station_position)
                }
            }
        }
        print(position_with_stationname)
    }
    
    
    
    
    
    
    
}
