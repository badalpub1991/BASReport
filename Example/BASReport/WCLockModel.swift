//
//  WCLockModel.swift
//  BASReport_Example
//
//  Created by Badal Shah on 22/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct RootClockClass : Decodable {
    let data : [clockData]?
    let message : String?
    let result : Int?
 }

struct clockData : Decodable {
    let Day : String?
    let H1_00mm : String?
    let H10_00mm : String?
    let H11_00mm : String?
    let H12_00mm : String?
    let H2_00mm : String?
    let H3_00mm : String?
    let H4_00mm : String?
    let H5_00mm : String?
    let H6_00mm : String?
    let H7_00mm : String?
    let H8_00mm : String?
    let H9_00mm : String?
    var imageFor12Oclock : String?
    var isCheck:Bool?
}
