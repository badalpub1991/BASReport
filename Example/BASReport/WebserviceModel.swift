//
//  WebserviceModel.swift
//  BASReport_Example
//
//  Created by Uffizio iMac2 on 10/10/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
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
  
