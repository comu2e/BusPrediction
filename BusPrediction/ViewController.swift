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
    let BusStopURL = NSBundle.mainBundle().URLForResource("MapDataMaster", withExtension: "json")!
    let BusStopURLFixed = NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!
    //BusStopDataFixedはMapDatamasterを整列しなおしたファイルです
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
   
}

