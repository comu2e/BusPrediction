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

class ViewController: UIViewController {
    
    let BusStopURLFixed = NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!
    let realm = try! Realm()
    //    各路線rosen_byorder要素ごとにおける駅名配列辞書
    var dictionary_rosen:NSDictionary!
    
    var rosen = try! Realm().objects(Rosen)
    
    var stationlist:StationsList!
    
    var cnt:Int! = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        //        Jsonファイルの読み込み
        parseRosenStationFromJson()
        //        realmに書き込み次回起動時はこのDBから読み出す
        //        realmがあるときは現在地を取得
        //        現在地を取得して近くのバス停をピン付する
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func parseRosenStationFromJson(){
        let BusData = NSData(contentsOfURL:self.BusStopURLFixed)!
        let rbo:rosen_by_order = try! Unbox(BusData)
        let rbo_int = rbo.rosen_by_order_Array
        //        rboの要素をクロージャーを使って文字列化
        let rbo_string = rbo_int.map{($0).description} as [String]!
        let bundle = NSBundle.mainBundle()
        
        if let path = bundle.pathForResource("BusStopDataFixed", ofType: "json")
        {
            do
            {
                let str = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                let data = str.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                //                元データ化からrosen配列をとりだす
                if (json["rosen"]  as? NSDictionary!) != nil
                {
                    do
                    {
                        for i in rbo_string
                        {
                            // rosenのデータをi(200001などで)取り出してdictionary_rosenにいれる
                            try realm.write
                                {let json_rosen = json["rosen"]
                                    if (json_rosen!["\(i)"] as? NSDictionary!) != nil
                                    {
                                        do
                                        {
                                            let data = json_rosen!["\(i)"]
//                                            print(String(data).utf8)
//                                            self.realm.add(self.rosen, update: true)
//                                            print(rosen.count)
                                        }
                                    }
                            }
                        }
                        //                     forループ
                        
                    }
                        
                    catch
                    {
                        print("json_rosen_error")
                    }
                }
            }
            catch
            {
                print("error")
            }
            
        }
            
        else{
            return
        }
    }
    
    
}



