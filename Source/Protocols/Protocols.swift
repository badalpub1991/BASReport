//
//  Protocols.swift
//  BASCustomReport
//
//  Created by iMac2 on 08/05/19.
//  Copyright © 2019 Badal Shah. All rights reserved.
//

import Foundation
import UIKit



let BASREPORT_BUNDLE = Bundle(for: BASCustomReport.self)



/**
 **Delegate for Report Selection**
 - Here you can Access Header Buttons Action , Whole view(BASReport as BASReportView) and Its Element
 /// - Parameters:
 `sender.accessibilityLabel` is Used for identify current Sorting (ascending , descending)
 ///  `btnPlaceHolder.accessibilityHint` is Used for identify Which Header is currently selected
 
 **/
 @objc public protocol BASReportDelegate {
    @objc optional  func selectedSorting(sender:UIButton , BASReportView:BASCustomReport , sorting:ComparisonResult)
    //@objc optional  func getIndexPath(indexPath:IndexPath , basReport:BASCustomReport?)
    @objc optional  func didSelectCellAt(indexPath:IndexPath , tableHint:String, basReport:BASCustomReport?)

}

public protocol BASReportDatasource :NSObject {
    func basReport(_ tableView: UITableView, cellForRowAt indexPath: IndexPath , column:Int) -> UITableViewCell
}

public protocol BASReportHeaderDatasource :NSObject {
    func basReport(_ tableView: UITableView, viewForHeaderInSection section: Int , column:Int) -> UIView?
}


