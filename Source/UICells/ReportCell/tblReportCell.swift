//
//  tblReportCell.swift
//  BASCustomReport
//
//  Created by iMac2 on 08/05/19.
//  Copyright © 2019 Badal Shah. All rights reserved.
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
    @IBOutlet weak var imgLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var imgWidthConstrain: NSLayoutConstraint!
    
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
        self.vwVerticalSeperator.backgroundColor = layoutSetting.PRIMARYREPORTDATA_SEPERATORCOLOR_VERTICLE
        self.ReportdataHorizontalSeperatorSize.constant = layoutSetting.REPORTDATAHORIZONTAL_SEPERATORSIZE
        self.ReportdataVerticalSeperatorSize.constant = layoutSetting.REPORTDATAVERTICAL_SEPERATORSIZE
        self.imgHeightConstrain.constant = layoutSetting.PRIMARYREPORTDATA_IMAGE_HEIGHTWIDTH.height
        self.imgWidthConstrain.constant = layoutSetting.PRIMARYREPORTDATA_IMAGE_HEIGHTWIDTH.width
    }
    
    func layoutSecondaryCell(layoutSetting:BASReportLayout) {
        self.lblReport.textColor = layoutSetting.SECONDARYREPORTDATA_TEXTCOLOR
        self.lblReport.font = layoutSetting.SECONDARYREPORTDATA_FONT
        self.lblReport.textAlignment = layoutSetting.SECONDARYREPORTDATA_TEXTALLIGNMENT
        self.backgroundColor = layoutSetting.SECONDARYREPORTDATA_BACKGROUNDCOLOR
        self.vwSeperator.backgroundColor = layoutSetting.SECONDARYREPORTDATA_SEPERATORCOLOR
        self.vwVerticalSeperator.backgroundColor = layoutSetting.SECONDARYREPORTDATA_SEPERATORCOLOR_VERTICLE
        self.ReportdataHorizontalSeperatorSize.constant = layoutSetting.REPORTDATAHORIZONTAL_SEPERATORSIZE
        self.ReportdataVerticalSeperatorSize.constant = layoutSetting.REPORTDATAVERTICAL_SEPERATORSIZE
        self.imgHeightConstrain.constant = layoutSetting.SECONDARYREPORTDATA_IMAGE_HEIGHTWIDTH.height
        self.imgWidthConstrain.constant = layoutSetting.SECONDARYREPORTDATA_IMAGE_HEIGHTWIDTH.width
    }
    
    func configurePrimaryReportData(reportTitle:String , needImage:OrderedDictionary<String, Bool>) {
        self.lblReport.text = reportTitle
    }
    
    
    func configureSecondaryReportData(reportTitle:String) {
        self.lblReport.text = reportTitle
    }
    
    
    func configurePrimaryReportDataImageAllignment(layoutSetting:BASReportLayout) {
        if layoutSetting.PRIMARYREPORTDATA_IMAGEALLIGNMENT == .left {
            if let imageConstrain = self.imgCenterConstraint {
                imageConstrain.isActive = false
            }
            self.imgLeftConstraint.isActive = true
            
        }
       
        
    }
    
}
