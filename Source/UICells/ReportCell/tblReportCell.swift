//
//  tblReportCell.swift
//  BASCustomReport
//
//  Created by Uffizio iMac2 on 08/05/19.
//  Copyright © 2019 Uffizio. All rights reserved.
//

import UIKit

class tblReportCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var lblReport: UILabel!
    @IBOutlet weak var imgReport: UIImageView!
    @IBOutlet weak var vwSeperator: UIView!
    @IBOutlet weak var vwVerticalSeperator: UIView!
    //Constrain Outlet
    @IBOutlet weak var ReportdataHorizontalSeperatorSize: NSLayoutConstraint!
    @IBOutlet weak var ReportdataVerticalSeperatorSize: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func layoutPrimaryCell(layoutSetting:BASReportLayout) {
        self.lblReport.textColor = layoutSetting.PRIMARYREPORTDATA_TEXTCOLOR
        self.lblReport.font = layoutSetting.PRIMARYREPORTDATA_FONT
        self.lblReport.textAlignment = layoutSetting.PRIMARYREPORTDATA_TEXTALLIGNMENT
        self.backgroundColor = layoutSetting.PRIMARYREPORTDATA_BACKGROUNDCOLOR
        self.vwSeperator.backgroundColor = layoutSetting.PRIMARYREPORTDATA_SEPERATORCOLOR
        self.ReportdataHorizontalSeperatorSize.constant = layoutSetting.REPORTDATAHORIZONTAL_SEPERATORSIZE
        self.ReportdataVerticalSeperatorSize.constant = layoutSetting.REPORTDATAVERTICAL_SEPERATORSIZE
    }
    
    func layoutSecondaryCell(layoutSetting:BASReportLayout) {
        self.lblReport.textColor = layoutSetting.SECONDARYREPORTDATA_TEXTCOLOR
        self.lblReport.font = layoutSetting.SECONDARYREPORTDATA_FONT
        self.lblReport.textAlignment = layoutSetting.SECONDARYREPORTDATA_TEXTALLIGNMENT
        self.backgroundColor = layoutSetting.SECONDARYREPORTDATA_BACKGROUNDCOLOR
        self.vwSeperator.backgroundColor = layoutSetting.SECONDARYREPORTDATA_SEPERATORCOLOR
        self.ReportdataHorizontalSeperatorSize.constant = layoutSetting.REPORTDATAHORIZONTAL_SEPERATORSIZE
        self.ReportdataVerticalSeperatorSize.constant = layoutSetting.REPORTDATAVERTICAL_SEPERATORSIZE
    }
    
    func configurePrimaryReportData(reportTitle:String) {
        self.lblReport.text = reportTitle
    }
    
    func configureSecondaryReportData(reportTitle:String) {
        self.lblReport.text = reportTitle
    }
    
}
