//
//  CLSubReportDataCell.swift
//  BASCustomReport
//
//  Created by Uffizio iMac2 on 08/05/19.
//  Copyright © 2019 Uffizio. All rights reserved.
//

import UIKit

class CLSubReportDataCell: UICollectionViewCell {

    /// All UIRelated Setting -> Headercolor , seperator Color , HeaderSize , SeperatorSize Bla Bla
    var layoutSettings = BASReportLayout()
    var delegate:BASReportDeleate?
    
    
    //Outlets
    @IBOutlet weak var tblReportSummary: UITableView!
    
    
    //Variables
    /// itemIndex is Index of CollectionView -> totalArray -1 Because First(object) is Already implimented Seperarely
    var itemIndex = IndexPath()
    /// SearchDictionary for search Functionality
    var arrReportSummaryDict  : [Dictionary<String, Any>] = []
    /// <String is HeaderName> and <Bool TRUE displayImage , FALSE display Text>
    var arrGHeader = OrderedDictionary<String, Bool>()
    
    /// 0. is Dictionary Keys(Json Webservice Keys) and 1. is Text Allignment(Left , Right , Center) to display Text  2.Custom CellWidth of Column 3. Custom BackGroundColor of Particular cell
    var arrGKeys = [keysAndAllignment]()
    /// .0 is for identify selected Header and .1 get current sorting for that Header(ascending and Descending)
    var validateSelectedLabel = ("","")
    
    var basCustomReport : BASCustomReport?
    
    var isSubCellClickable = false

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCells()
        
    }
    
    //Register Nibs
    func registerCells() {
        tblReportSummary.register(UINib(nibName: "tblCellHeader", bundle: BASREPORT_BUNDLE), forCellReuseIdentifier: "tblCellHeader")
        tblReportSummary.register(UINib(nibName: "tblReportCell", bundle: BASREPORT_BUNDLE), forCellReuseIdentifier: "tblReportCell")
        
    }

}

extension CLSubReportDataCell : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:tblCellHeader = tableView.dequeueReusableCell(withClass: tblCellHeader.self)
        cell.validateSelectedLabel = self.validateSelectedLabel
        
        cell.btnPlaceHolder.addTarget(BASCustomReport(), action: #selector(BASCustomReport().btnSortingTapped(_:)), for: .touchUpInside)
        
        if arrGHeader.count > 0 {
            cell.configureSecondaryHeaderCell(headerTitle: Array(arrGHeader.keys)[itemIndex.item + 1])
            cell.btnPlaceHolder.accessibilityHint = cell.lblHeaderName.text
        }
        cell.layoutSecondaryHeader(layoutSetting: self.layoutSettings)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.layoutSettings.HEADER_SIZE
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.layoutSettings.CELL_SIZE
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReportSummaryDict.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:tblReportCell = tableView.dequeueReusableCell(withClass: tblReportCell.self)
        cell.layoutSecondaryCell(layoutSetting: self.layoutSettings)
        cell.selectionStyle = .none
        
        let key = Array(arrGHeader.keys)[itemIndex.item + 1]
        if arrGHeader[key] == true {
            cell.lblReport.text = ""
            cell.imgReport.image = UIImage(named: (self.arrReportSummaryDict[indexPath.row][arrGKeys[itemIndex.item + 1].0] as! String))
        } else {
            cell.imgReport.image = nil //UIImage(named: "")
            if let text = self.arrReportSummaryDict[indexPath.row][arrGKeys[itemIndex.item + 1].0] as? Int {
                cell.lblReport.text = text.toString()
            }
            if let text = self.arrReportSummaryDict[indexPath.row][arrGKeys[itemIndex.item + 1].0] as? Float {
                cell.lblReport.text = text.toString()
            }
            if let text = self.arrReportSummaryDict[indexPath.row][arrGKeys[itemIndex.item + 1].0] as? Double {
                cell.lblReport.text = text.toString()
            }
            if let text = self.arrReportSummaryDict[indexPath.row][arrGKeys[itemIndex.item + 1].0] as? String {
                cell.lblReport.text = text
            }
            
            cell.lblReport.textAlignment = arrGKeys[itemIndex.item + 1].1
            if arrGKeys[itemIndex.item + 1].3 != nil {
                if !isSubCellClickable {
                cell.contentView.backgroundColor = arrGKeys[itemIndex.item + 1].3
                } else {
                    cell.lblReport.textColor = arrGKeys[itemIndex.item + 1].3
                }
            }   
        }
        
        
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.basCustomReport?.needToScroll(scrollView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.getItemIndexPath?(indexPath: indexPath, tableHint: tableView.accessibilityHint!, basReport: self.basCustomReport)
    }
    
    
}

