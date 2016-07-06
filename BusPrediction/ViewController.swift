//
//  ViewController.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/04.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//

import UIKit
import RealmSwift
import Unbox
import SwiftyJSON
import ObjectMapper
class ViewController: UIViewController {
    
    let BusStopURLFixed = NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!
    //    各路線rosen_byorder要素ごとにおける駅名配列辞書
    var dictionary_rosen:NSDictionary!
    
    //    var rosen = try! Realm().objects(Rosen)
    
    //    var stationlist:StationsList!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        Jsonファイルの読み込み
        jsonParseWithSwiftyJson()
        //        realmに書き込み次回起動時はこのDBから読み出す
        //        realmがあるときは現在地を取得
        //        現在地を取得して近くのバス停をピン付する
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func jsonParseWithSwiftyJson()  {
        let BusData = NSData(contentsOfURL:self.BusStopURLFixed)!
        //      UNbox使ってるけどつかわなくてもよい
        let rbo:rosen_by_order = try! Unbox(BusData)
        let rbo_int = rbo.rosen_by_order_Array
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
        
        let rbo_string = rbo_int.map{($0).description} as [String]!
        let json = JSON(data:BusData)
        //        
        for i in rbo_string{
            if  json != nil{
                let stations = json["rosen"]["\(i)"]["stations"].arrayObject
                let companyid = json["rosen"]["\(i)"]["companyid"].int
                let dest = json["rosen"]["\(i)"]["dest"].string
                let expl = json["rosen"]["\(i)"]["expl"].string
                let name = json["rosen"]["\(i)"]["name"].string
                
                for station in stations!{
                    let lat = json["station"]["\(station)"]["lat"].float
                    let lng = json["station"]["\(station)"]["lng"].float
                    //                   この処理に4minかかるのでこの方法は効率的でない
                    //                    まずlat,lng情報を元にピン付する
                    //                    方針  現在地を取得してその周囲(例えば5km以内)のピンだけを地図上に表示
                    //                          ピンをタップするとlat,lng情報に当てはまるデータだけをピンのセルに表示
                    
                    if lat != nil{
                        
                    }
                    
                }
            }
        }
        //                realmに入れれば使いやすくなってよい？
        //                プライマリーキーをなににする？
    }
}



