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
//    let BusStopURLFixed = NSBundle.mainBundle().URLForResource("BusStopDataFixed", withExtension: "json")!

    override func viewDidLoad() {
        super.viewDidLoad()
        let start = NSDate()
        let BusData = NSData(contentsOfURL:self.BusStopURL)!
        print(BusData)
        let elapsed = NSDate().timeIntervalSinceDate(start)
        print(elapsed)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJsonData() {
        
    }
    

}

