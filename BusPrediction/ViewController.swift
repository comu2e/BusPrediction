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
    let dictionary_rosen:[Int:[String]]! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Jsonファイルの読み込み
        let BusData = NSData(contentsOfURL:self.BusStopURLFixed)!
//        Unboxインスタンス
        let rbo:rosen_by_order = try! Unbox(BusData)
//        let rosen:Rosen = try! Unbox(BusData)
        
        let rbo_int = rbo.rosen_by_order_Array
//        rboの要素をクロージャーを使って文字列化
        let rbo_string = rbo_int.map{($0).description}
//        Rosenから各stations[String]を取り出す
//        そしてそれらをdictionary[rbo] = [String]としてDB化
//        rbo_stringそれぞれの要素iについてそれをkeyとしてdest,[stations]を取り出していきたい
        for i in rbo_string
            {
            
                struct Rosen:Unboxable
                {
                    let dest:String
                    let companyid:Int
                    let expl:String
                    let statinos:[String]
                    let name:String
                        init(unboxer: Unboxer)
                        {
                            self.dest = unboxer.unbox("rosen.(\(i).dest",isKeyPath: true)
                            self.companyid = unboxer.unbox("rosen.\(i).companyid",isKeyPath: true)
                            self.expl = unboxer.unbox("rosen.\(i).expl",isKeyPath: true)
                            self.statinos = unboxer.unbox("rosen.\(i).stations",isKeyPath: true)
                            self.name = unboxer.unbox("rosen.\(i).name",isKeyPath: true)
                        }
                }
            let rosen:Rosen = try! Unbox(BusData)
            dictionary_rosen[i] = [rosen.dest,rosen.companyid...]
            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
   
}

