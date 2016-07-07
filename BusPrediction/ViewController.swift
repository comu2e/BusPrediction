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
import MapKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{
    /*
     JSONデータ
     let BusData = NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)
     let json = JSON(data:NSData(contentsOfURL:NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!)!)
     バンドルしておいたRealmファイルを読み込み
     
     各路線rosen_byorder要素ごとにおける駅名配列辞書
     var dictionary_rosen:NSDictionary!
     realmインスタンス
     */
    @IBOutlet weak var MapView: MKMapView!
    var lm: CLLocationManager! = nil
    var myLocationManager:CLLocationManager!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //        JSONからRealmファイル作るときにコメントアウトすればいい
        //        json_to_realm()
        
        
        let config = Realm.Configuration(
            fileURL: NSBundle.mainBundle().URLForResource("Position", withExtension: "realm"),
            readOnly: true)
        
        let realm_position = try! Realm(configuration: config)
        let StationArray = realm_position.objects(StationPositionRealm).sorted("StationName", ascending: false)
        
        
        //        realmに書き込み次回起動時はこのDBから読み出す
        
        lm = CLLocationManager()
        lm.delegate = self
        
        lm.requestAlwaysAuthorization()
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.distanceFilter = 300
        lm.startUpdatingLocation()
        
        //        realmがあるときは現在地を取得
        //        現在地を取得して近くのバス停をピン付する
        
        PinnningToMap(StationArray)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func PinnningToMap(StationArray:Results<StationPositionRealm>) {
        /*
         この方法だと起動時に余分なピンが打たれてしまい重くなる
         for station_name in StationArray{
         // MapViewを生成.
         let lattitude = (station_name.positions?.lat)! as CLLocationDegrees
         let longtitude = (station_name.positions?.lng)! as CLLocationDegrees
         
         //中心座標
         let center = CLLocationCoordinate2DMake(lattitude, longtitude)
         
         //表示範囲
         let span = MKCoordinateSpanMake(0.01, 0.01)
         
         //中心座標と表示範囲をマップに登録する。
         let region = MKCoordinateRegionMake(center, span)
         MapView.setRegion(region, animated:true)
         
         //地図にピンを立てる。
         let annotation = MKPointAnnotation()
         annotation.coordinate = CLLocationCoordinate2DMake(lattitude, longtitude)
         MapView.addAnnotation(annotation)
         
         }
         */
    }
}

