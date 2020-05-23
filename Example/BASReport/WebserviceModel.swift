//
//  WebserviceModel.swift
//  BASReport_Example
//
//  Created by iMac2 on 08/05/19.
//  Copyright © 2019 Badal Shah. All rights reserved.
//

import Foundation
struct RootClass : Decodable {
    let data : [SampleData]?
    let message : String?
    let result : Int?
 }

struct SampleData : Decodable {
      let distance : Double?
      let idle : String?
      let max_temperature : Double?
      let min_temperature : Double?
      let no_below_ideal : Double?
      let object : String?
      let redirect_screen_id : Int?
      let running : String?
    var imageName : String?
  }
  
