//
//  ViewController.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/04.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//
//        ここにすべてのバス停情報をいれていく
//        後にここから重複すvar要素をはぶき，unique_arrayとしてかえす
//      rboの要素をクロージャーを使って文字列var
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
import Realm
class ViewController: UIViewController {
    //    JSONデータ
    //    let BusData = NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)
    //    let json = JSON(data:NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)!)
    //    バンドルしておいたRealmファイルを読み込み
    
    //    各路線rosen_byorder要素ごとにおける駅名配列辞書
    //    var dictionary_rosen:NSDictionary!
    //  realmインスタンス
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let config = Realm.Configuration(
            // アプリケーションバンドルのパスを設定します
            fileURL: NSBundle.mainBundle().URLForResource("Position", withExtension: "realm"),
            // アプリケーションバンドルは書き込み不可なので、読み込み専用に設定します。
            readOnly: true)
        
        let realm_position = try! Realm(configuration: config)
        
        let StationArray = realm_position.objects(StationPositionRealm).sorted("StationName", ascending: false)
        
        
        
        for staion in StationArray {
            print("station:\(staion.StationName)")
            print("lat:\(staion.positions?.lat)")
            print("lng:\(staion.positions?.lng)")
            
        }
        //        realmに書き込み次回起動時はこのDBから読み出す
        
        //        realmがあるときは現在地を取得
        //        現在地を取得して近くのバス停をピン付する
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
