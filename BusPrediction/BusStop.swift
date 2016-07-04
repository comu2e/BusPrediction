//
//  BusStop.swift
//  BusPrediction
//
//  Created by Eiji Takahashi on 2016/07/05.
//  Copyright © 2016年 devlpEiji. All rights reserved.
//


/*
JSONファイルの構造
    {
        ①station:
        {
           ② StationName構造体:
            {②`
            "exflag" : Int,
            "ekidiv" : String,
            "selectname" : String,
            "stationtype" : Int,
            "kyotoflag" : Int,
            "lat" : Float,
            "lng" : Float
            }
            
        },
 ,
 ③rosen_byorder:[Int]　//この配列を最初に読み込まなければならない？
                        読み込みそれぞれの値(ex:20001)
rosen構造体内でそれぞれの値(20001)の要素,dest,companyidなどを読み込む
 ,
        ④rosen:
        {
            ④`rosen_byorder_string構造体[comment:rosen_byorderをString化これをrosen_by_order_element_stringとする]:
            { ④``下の情報をrosen_info構造体とする
                dest:String,
                companyid:Int,
                expl:String,
                statinos:[String],
                name:String
            }
        },
        
        ⑤company:
        {
          ⑤`  company_byorder_element:
            {⑤``下記の情報をcompany_byorder_element_infoとする
                name:String
                ekidiv:String
            }
        },
        company_byorder:[String] (数字103などをString化"103"としているこの要素をcompany_byorder_elementとする),
        coefficient:{
            BUS_CO2_EMISSION_RATE : 48,
            TRAIN_CO2_EMISSION_RATE : 18,
            WALK_CALORIE_RATE : 3.15,
            SEARCH_FIRST_DEPARTURE_TIME : "04:00",
            SEARCH_NEXT_INTERVAL_TIME : 10,
            MASTER_UPDATE_DATETIME : "2016\/04\/29 00:00",
            SEARCH_NEAR_SPOTS_NUMBER : 5,
            WALK_STEPS_RATE : 100,
            CAR_CO2_EMISSION_RATE : 165,
            SESRCH_LAST_ARRIVAL_TIME : "03:59"
        },
        stationselect:
        {
            timei:
            {
                companyid:Int
                stationnames:[{companyid:Int,stationname:String}],
                byname:String!
                kana:String
                
            }
        }
 }
 
*/
struct station {
    let station: StationName
    
}

struct StationName {
    let  exflag : Int
    let  ekidiv : String
    let  selectname : String
    let  stationtype : Int
    let  kyotoflag : Int
    let  lat : Float
    let  lng : Float
}


struct rosen_by_order{
    let rosen_by_order_Array:[Int]
}

struct rosen {
    let rosen_by_order_element_string : rosen_info
}

struct rosen_info{
    let dest:String
    let companyid:Int
    let expl:String
    let statinos:[String]
    let name:String
}

struct company {
    let company_byorder_element_info:company_byorder_element
}

struct company_byorder_element {
    let name:String
    let ekidiv:String
}



