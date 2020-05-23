//
//  BASReportLayout.swift
//  BASCustomReport
//
//  Created by iMac2 on 08/05/19.
//  Copyright © 2019 Badal Shah. All rights reserved.
//

import Foundation
import UIKit

public class BASReportLayout {
    //PrimaryHeader
    /// PrimaryHeader(First Tableview) BackGround Color Default is OffWhite "F8F8F8"
    public  var PRIMARYHEADER_BACKGROUNDCOLOR : UIColor = UIColor(hexString: "F8F8F8")
    /// PrimaryHeader Text Color Default is Black
    public  var PRIMARYHEADER_TEXTCOLOR = UIColor.black
    /// PrimaryHeader Font Default is System with Size 12.0
    public  var PRIMARYHEADER_FONT = UIFont.systemFont(ofSize: 12.0)
    /// PrimaryHeader SelectedFont Default is SystemBold with Size 12.0
    public var PRIMARYHEADERSELECTED_FONT = UIFont.boldSystemFont(ofSize: 12.0)
    /// PrimaryHeader Seperator Color Default is UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    public var PRIMARYHEADER_SEPERATORCOLOR = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    /// PrimaryHeader Allignment **Default is .left**
    public var PRIMARYHEADER_TEXTALLIGNMENT:NSTextAlignment = .left
    
    //SecondaryHeader
    /// SecondaryHeader(FromSecond Tableview) BackGround Color Default is OffWhite "F8F8F8"
    public var SECONDARYHEADER_BACKGROUNDCOLOR = UIColor(hexString: "F8F8F8")
    /// SecondaryHeader Text Color Default is Black
    public  var SECONDARYHEADER_TEXTCOLOR = UIColor.black
    /// SecondaryHeader Font Default is System with Size 12.0
    public var SECONDARYHEADER_FONT = UIFont.systemFont(ofSize: 12.0)
    /// SecondaryHeader SelectedFont Default is SystemBold with Size 12.0
    public var SECONDARYHEADERSELECTED_FONT = UIFont.boldSystemFont(ofSize: 12.0)
    /// SecondaryHeader Seperator Color Default is UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    public var SECONDARYHEADER_SEPERATORCOLOR = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    /// SecondaryHeader Allignment **Default is .left**
    public var SECONDARYHEADER_TEXTALLIGNMENT:NSTextAlignment = .center
    
    
    
    //PrimaryREPORTDATA
    /// Primary(1st) ReportData BackGround Color Default is OffWhite "F8F8F8"
    public var PRIMARYREPORTDATA_BACKGROUNDCOLOR : UIColor = UIColor(hexString: "F8F8F8")
    /// Primary(1st) ReportData TextColor Default is Black.
    public var PRIMARYREPORTDATA_TEXTCOLOR = UIColor.black
    /// Primary(1st) ReportData Font Default is System with Size 12.0
    public var PRIMARYREPORTDATA_FONT = UIFont.systemFont(ofSize: 12.0)
    /// Primary(1st) ReportData Seperator Color Default is UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    public var PRIMARYREPORTDATA_SEPERATORCOLOR = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    /// Primary(1st) ReportData Verticle Seperator Color Default is UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    public var PRIMARYREPORTDATA_SEPERATORCOLOR_VERTICLE = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    
    /// Primary(1st) ReportData Image Height and Width **Default is 15.0**
    public var PRIMARYREPORTDATA_IMAGE_HEIGHTWIDTH:CGSize = CGSize(width: 15.0, height: 15.0)
    /// Primary(1st) ReportData Allignment **Default is .left**
    public var PRIMARYREPORTDATA_TEXTALLIGNMENT:NSTextAlignment = .left
    /// Primary(1st) ReportData Image **Default is .Center**
    public var PRIMARYREPORTDATA_IMAGEALLIGNMENT:NSTextAlignment = .center
    
    //SecondaryREPORTDATA
    /// Secondary ReportData BackGround Color Default is White "UIColor.white".
    public  var SECONDARYREPORTDATA_BACKGROUNDCOLOR : UIColor = UIColor.white
    /// Secondary ReportData TextColor Default is Black.
    public var SECONDARYREPORTDATA_TEXTCOLOR = UIColor.black
    /// Secondary ReportData Font Default is System with Size 12.0
    public var SECONDARYREPORTDATA_FONT = UIFont.systemFont(ofSize: 12.0)
    /// Secondary ReportData Seperator Color Default is UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    public var SECONDARYREPORTDATA_SEPERATORCOLOR = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    /// Secondary ReportData Verticle Seperator Color Default is UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    public var SECONDARYREPORTDATA_SEPERATORCOLOR_VERTICLE = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    /// Secondary ReportData Image Height and Width **Default is 15.0**
    public var SECONDARYREPORTDATA_IMAGE_HEIGHTWIDTH:CGSize = CGSize(width: 15.0, height: 15.0)
    /// Secondary ReportData Allignment **Default is .left**
    public var SECONDARYREPORTDATA_TEXTALLIGNMENT:NSTextAlignment = .left
    
    //Size VARIABLES
    /// Set Report HeaderSize Default is 44.0
    public var HEADER_SIZE:CGFloat = 44.0
    /// Set ReportData Cell Size Default is 44.0
    public var CELL_SIZE:CGFloat = 44.0
    //PrimaryHeader Seperator Size
    /// set Header Horizontal Seperator Size Default is 1.0
    public var HEADERHORIZONTAL_SEPERATORSIZE:CGFloat = 1.0
    /// set ReportData Horizontal Seperator Size Default is 1.0
    public var REPORTDATAHORIZONTAL_SEPERATORSIZE:CGFloat = 1.0
    //
    /// Set Header Vertical SeperatorSize = 1.0
    public var HEADERVERTICAL_SEPERATORSIZE:CGFloat = 1.0
    /// Set ReportData Vertical SeperatorSize Default is 1.0
    public  var REPORTDATAVERTICAL_SEPERATORSIZE:CGFloat = 1.0
    
    
    /// Set Ascending Order Image
    public  var ASCENDING_IMAGE:UIImage = UIImage(named: "ASCImage.png", in: BASREPORT_BUNDLE, compatibleWith: nil)!
    
    /// Set Descending Order Image
    public var DESCENDING_IMAGE:UIImage = UIImage(named: "DSCImage.png", in: BASREPORT_BUNDLE, compatibleWith: nil)!
    
    /// Set NORecord Found Font
    public var NODATA_FONT = UIFont.systemFont(ofSize: 12.0)
    
    /// Set No record Found TextColor
    public  var NODATA_TEXTCOLOR = UIColor.black
    
    ///Change All Seperator Size
    public func setAllSeperatorWithSize(size:CGFloat) {
        self.HEADERHORIZONTAL_SEPERATORSIZE = size
        self.REPORTDATAHORIZONTAL_SEPERATORSIZE = size
        self.HEADERVERTICAL_SEPERATORSIZE = size
        self.REPORTDATAVERTICAL_SEPERATORSIZE = size
    }
    
    ///Set All Font (Header and Data Both)
    public func setAllFontWithSize(font:UIFont) {
        PRIMARYHEADER_FONT = font
        SECONDARYHEADER_FONT = font
        PRIMARYREPORTDATA_FONT = font
        SECONDARYREPORTDATA_FONT = font
    }
    
    ///Change All Header Default TextColor
    public func setAllHeaderTextColor(headerTextColor:UIColor) {
        PRIMARYHEADER_TEXTCOLOR = headerTextColor
        SECONDARYHEADER_TEXTCOLOR = headerTextColor
    }
    
    ///Change All Header Background Color
    public func setAllHeaderBackgroundColor(headerBGColor:UIColor) {
        PRIMARYHEADER_BACKGROUNDCOLOR = headerBGColor
        SECONDARYHEADER_BACKGROUNDCOLOR = headerBGColor
    }
    
    ///Change All Headers Font Only
    public func setAllHeaderFont(font:UIFont) {
        PRIMARYHEADER_FONT = font
        SECONDARYHEADER_FONT = font
    }
    
    ///Change All Data's Font Only
    public func setAllDataFont(font:UIFont) {
        PRIMARYREPORTDATA_FONT = font
        SECONDARYREPORTDATA_FONT = font
    }
    
    ///By Default cell Contain Image. So, with this you can Change ImageSize
    public func setAllDataImageSize(imageSize:CGSize) {
        PRIMARYREPORTDATA_IMAGE_HEIGHTWIDTH = imageSize
        SECONDARYREPORTDATA_IMAGE_HEIGHTWIDTH = imageSize
    }
    
    public func setAllPrimaryAllignment(allignment:NSTextAlignment) {
        self.PRIMARYREPORTDATA_TEXTALLIGNMENT = allignment
    }
}
