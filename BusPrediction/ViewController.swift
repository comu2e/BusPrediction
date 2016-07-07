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

class ViewController: UIViewController ,  MKMapViewDelegate, CLLocationManagerDelegate {
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
    var positionManager:CLLocationManager = CLLocationManager()
    
    
    //画面表示後の呼び出しメソッド
    override func viewDidAppear(animated: Bool) {
        
        if(CLLocationManager.locationServicesEnabled() == true){
            switch CLLocationManager.authorizationStatus() {
                
            //未設定の場合
            case CLAuthorizationStatus.NotDetermined:
                positionManager.requestWhenInUseAuthorization()
                
            //機能制限されている場合
            case CLAuthorizationStatus.Restricted:
                alertMessage("位置情報サービスの利用が制限されている利用できません。「設定」⇒「一般」⇒「機能制限」")
                
            //「許可しない」に設定されている場合
            case CLAuthorizationStatus.Denied:
                alertMessage("位置情報の利用が許可されていないため利用できません。「設定」⇒「プライバシー」⇒「位置情報サービス」⇒「アプリ名」")
                
            //「このAppの使用中のみ許可」に設定されている場合
            case CLAuthorizationStatus.AuthorizedWhenInUse:
                //位置情報の取得を開始する。
                positionManager.startUpdatingLocation()
                
            //「常に許可」に設定されている場合
            case CLAuthorizationStatus.AuthorizedAlways:
                //位置情報の取得を開始する。
                positionManager.startUpdatingLocation()
            }
            
        } else {
            //位置情報サービスがOFFの場合
            alertMessage("位置情報サービスがONになっていないため利用できません。「設定」⇒「プライバシー」⇒「位置情報サービス」")
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //        JSONからRealmファイル作るときにコメントアウトすればいい
        //        json_to_realm()
        
        //        Realm読み込み
        let config = Realm.Configuration(
            fileURL: NSBundle.mainBundle().URLForResource("Position", withExtension: "realm"),
            readOnly: true)
        let realm_position = try! Realm(configuration: config)
        let StationArray = realm_position.objects(StationPositionRealm).sorted("StationName", ascending: false)
        //現在地の取得
        //デリゲート先に自分を設定する。
        self.positionManager.delegate = self
        self.MapView.delegate = self
        
        //位置情報の取得を開始する。
        positionManager.startUpdatingLocation()
        
        //位置情報の利用許可を変更する画面をポップアップ表示する。
        positionManager.requestWhenInUseAuthorization()
        
        // MapViewに反映.
        PinnningToMap(StationArray)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    //メッセージ出力メソッド
    func alertMessage(message:String) {
        let aleartController = UIAlertController(title: "注意", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title:"OK", style: .Default, handler:nil)
        aleartController.addAction(defaultAction)
        
        presentViewController(aleartController, animated:true, completion:nil)
        
    }
    
    func PinnningToMap(StationArray:Results<StationPositionRealm>) {
        // Realmデータベース内にある駅をピン付する
        //        ピンをタップしたらその駅名を表示，サーバーに送信すればいい
        //         この方法だと起動時に余分なピンが打たれてしまい重くなる
        //        解決策　現在地の座標を取得してその周辺だけピンを打てばいい
        //        Realm内で検索して条件に合うものだけの配列を作る
        for station_name in StationArray{
            let station_lattitude = (station_name.positions?.lat)! as CLLocationDegrees
            let station_longtitude = (station_name.positions?.lng)! as CLLocationDegrees
            
            //地図にピンを立てる。
            let annotation = MKPointAnnotation()
            annotation.title = station_name.StationName
            
            annotation.coordinate = CLLocationCoordinate2DMake(station_lattitude, station_longtitude)
            self.MapView.addAnnotation(annotation)
            
        }
        //
    }
    //    ピンをタップした時にサーバーに送る動作
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        for view in views {
            view.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        }
        
    }
    
    //位置情報取得時の呼び出しメソッド
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            
            //中心座標
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
            //表示範囲
            let span = MKCoordinateSpanMake(0.01, 0.01)
            
            //中心座標と表示範囲をマップに登録する。
            let region = MKCoordinateRegionMake(center, span)
            self.MapView.setRegion(region, animated:true)
            
            //ピンを作成してマップビューに登録する。
            let myannotation = MKPointAnnotation()
            myannotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
        }
    }
}

