//
//  tblCellHeader.swift
//  BASCustomReport
//
//  Created by iMac2 on 08/05/19.
//  Copyright © 2019 Badal Shah. All rights reserved.
//

import UIKit

class tblCellHeader: UITableViewCell {

    //OUTLETS
    @IBOutlet weak var lblHeaderName: UILabel!
    @IBOutlet weak var imgAscDscImageView: UIImageView!
    @IBOutlet weak var vwSeperator: UIView!
    @IBOutlet weak var vwVerticalSeperator: UIView!
    @IBOutlet weak var btnPlaceHolder: UIButton!
    
    //Constrain Outlet
    /// Modify Horizontal Seperator Size
    @IBOutlet weak var ReportdataHorizontalSeperatorSize: NSLayoutConstraint!
    /// Modify Vertical Seperator Size
    @IBOutlet weak var ReportdataVerticalSeperatorSize: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    //Variables
    /// .0 is for identify selected Header and .1 get current sorting for that Header(ascending and Descending)
    var validateSelectedLabel = ("","")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnPlaceHolder.accessibilityLabel = ""
        imageViewWidth.constant = 0.0
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func layoutPrimaryHeader(layoutSetting:BASReportLayout) {
        self.lblHeaderName.textColor = layoutSetting.PRIMARYHEADER_TEXTCOLOR
        self.lblHeaderName.font = layoutSetting.PRIMARYHEADER_FONT
        //Setup Sorting Related Data
        if btnPlaceHolder.accessibilityHint == self.validateSelectedLabel.0 {
            self.lblHeaderName.font = layoutSetting.PRIMARYHEADERSELECTED_FONT
            self.imgAscDscImageView.image = validateSelectedLabel.1.ascDscImage(layoutSetting: layoutSetting)
            self.btnPlaceHolder.accessibilityLabel = validateSelectedLabel.1
            imageViewWidth.constant = 15
        }
        self.lblHeaderName.textAlignment = layoutSetting.PRIMARYHEADER_TEXTALLIGNMENT
        self.backgroundColor = layoutSetting.PRIMARYHEADER_BACKGROUNDCOLOR
        self.vwSeperator.backgroundColor = layoutSetting.PRIMARYHEADER_SEPERATORCOLOR
        self.ReportdataHorizontalSeperatorSize.constant = layoutSetting.HEADERHORIZONTAL_SEPERATORSIZE
        self.ReportdataVerticalSeperatorSize.constant = layoutSetting.HEADERVERTICAL_SEPERATORSIZE
    }
    
    func layoutSecondaryHeader(layoutSetting:BASReportLayout) {
        self.lblHeaderName.textColor = layoutSetting.SECONDARYHEADER_TEXTCOLOR
        self.lblHeaderName.font = layoutSetting.SECONDARYHEADER_FONT
        //Setup Sorting Related Data
        if btnPlaceHolder.accessibilityHint == self.validateSelectedLabel.0 {
            self.lblHeaderName.font = layoutSetting.SECONDARYHEADERSELECTED_FONT
            self.imgAscDscImageView.image = validateSelectedLabel.1.ascDscImage(layoutSetting: layoutSetting)
            self.btnPlaceHolder.accessibilityLabel = validateSelectedLabel.1
            imageViewWidth.constant = 15
        }
        self.lblHeaderName.textAlignment = layoutSetting.SECONDARYHEADER_TEXTALLIGNMENT
        self.backgroundColor = layoutSetting.SECONDARYHEADER_BACKGROUNDCOLOR
        self.vwSeperator.backgroundColor = layoutSetting.SECONDARYHEADER_SEPERATORCOLOR
        self.ReportdataHorizontalSeperatorSize.constant = layoutSetting.HEADERHORIZONTAL_SEPERATORSIZE
        self.ReportdataVerticalSeperatorSize.constant = layoutSetting.HEADERVERTICAL_SEPERATORSIZE
    }
    
    func configurePrimaryHeaderCell(headerTitle:String) {
        self.lblHeaderName.text = headerTitle
    }
    
    func configureSecondaryHeaderCell(headerTitle:String) {
        self.lblHeaderName.text = headerTitle
    }
    
}
