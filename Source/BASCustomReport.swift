//
//  BASCustomReport.swift
//  BASCustomReport
//
//  Created by iMac2 on 08/05/19.
//  Copyright © 2019 Badal Shah. All rights reserved.
//

import UIKit

let HEADERCELL_IDENTIFIER = "tblCellHeader"
let SUBCELL_IDENTIFIER = "tblReportCell"
/// This will FlipCollectionview as par the launguage support. RTL - LTR
extension UICollectionViewFlowLayout {

    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
/// 0. is Dictionary Keys and 1. is Text Allignment to display Text  2.Custom CellWidth 3. Custom BackGroundColor
public typealias keysAndAllignment = (String,NSTextAlignment,CGFloat?,UIColor?)
// 0. is Dictionary Keys and
//1. is Text Allignment to display Text
//2.Custom CellWidth
//3. Custom BackGroundColor

///BASReportCustomCell is Array of UINib and Identifier
public typealias BASReportCustomCell = (UINib,String)

                                    
public class BASCustomReport: UIView {

    /// All UIRelated Setting -> Headercolor , seperator Color , HeaderSize , SeperatorSize Bla Bla
    public  var layoutSettings = BASReportLayout()
    //Outlets
    @IBOutlet weak var tblReportSummary: UITableView!
    @IBOutlet weak public var colReportSummary: UICollectionView!
    @IBOutlet weak private var vwBackup: UIView!
    @IBOutlet weak public var delegate:BASReportDelegate?
    ///This datasource is used to Display customCells in **TableViewData**
    weak public var basReportDatasource: BASReportDatasource?
    /// Need to specify index on which **COLUMN** you need custom cell
     public var arrCustomIndexPathForColumn : [Int] = []
    @IBOutlet weak var firstColumnWidth: NSLayoutConstraint!
    
    ///This datasource is used to Display customCells for header in **TableViewData**
       weak public var basReportHeaderDatasource: BASReportHeaderDatasource?
       /// Need to specify index on which **COLUMN** you need custom cell for header
        public var arrCustomHeaderSectionForColumn : [Int] = []

    @IBOutlet weak private var lblNoRecordFound: UILabel!
    
    
    /// If you want to set textColor of someCell
    public var isSubCellClickable = false
    
    //Variable Colors
    var seperatorColor = UIColor.red
    
    //Storage Variables
    /// String array of SeachKey -> Pass String in Array of SearchKey
   public var arrSearchKey = [String]()
    /// Dictionary of ActualData with Key Value
   public var arrReportSummaryDict  : [Dictionary<String, Any>] = []{
        didSet{
            if  tblReportSummary != nil && colReportSummary != nil  {
                // reloadUIAfterData()
                DispatchQueue.main.async {
                    self.vwBackup.layer.borderWidth = self.layoutSettings.HEADERVERTICAL_SEPERATORSIZE
                    self.vwBackup.layer.borderColor = self.layoutSettings.PRIMARYHEADER_SEPERATORCOLOR.cgColor
                    self.reloadData()
                }
                lblNoRecordFound.isHidden = arrReportSummaryDict.count > 0 ? true : false
            }
        }
    }
    /// SearchDictionary for search Functionality
    public var arrSearchReportSummaryDict  : [Dictionary<String, Any>] = []
    /// <String is HeaderName> and <Bool TRUE displayImage , FALSE display Text>
    open var arrGHeader = OrderedDictionary<String, Bool>(){
        didSet{
            self.tblReportSummary.accessibilityHint = arrGHeader.keys[0]
        }
    }
    
    /// 0.is Dictionary Keys(Json Webservice Keys) 1. is Text Allignment(Left , Right , Center) to display Text 2.Custom CellWidth of Column 3.Custom BackGroundColor of Particular cell
    public var arrGKeys = [keysAndAllignment](){
        didSet{
            if let size = arrGKeys[0].2 {
                firstColumnWidth.constant = size
                self.layoutIfNeeded()
            }
        }
    }
    /// .0 is for identify selected Header and .1 get current sorting for that Header(ascending and Descending)
   public var validateSelectedLabel = ("","")
    /// Maintain the Scroll For All View
    var arrTableView = [UITableView]()
    
    fileprivate var arrCustomCell = [BASReportCustomCell]()
    
    //Initial Setup
    var view: UIView!
    
    /// store global calculated width
    var screen_Width_Calc:CGFloat = 0.0
    
    /// store global calculated Header  width
    var screen_Header_Width_Calc:CGFloat = 0.0

  
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        loadViewFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
        
    }
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
        registerCells()
    }
    
    //Register Nibs
   fileprivate func registerCells() {
        self.lblNoRecordFound.font = layoutSettings.NODATA_FONT
        self.lblNoRecordFound.textColor = layoutSettings.NODATA_TEXTCOLOR
        tblReportSummary.register(UINib(nibName: HEADERCELL_IDENTIFIER, bundle: BASREPORT_BUNDLE), forCellReuseIdentifier: HEADERCELL_IDENTIFIER)
        tblReportSummary.register(UINib(nibName: SUBCELL_IDENTIFIER, bundle: BASREPORT_BUNDLE), forCellReuseIdentifier: SUBCELL_IDENTIFIER)
        colReportSummary.register(UINib(nibName: "CLSubReportDataCell", bundle: BASREPORT_BUNDLE), forCellWithReuseIdentifier: "CLSubReportDataCell")
        self.tblReportSummary.tag = 0
    
        self.tblReportSummary.accessibilityIdentifier = "TABLE1"
        self.arrTableView.append(self.tblReportSummary)
        
       
        
        //YourCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft

    }
    
    /// you need to passArray of **UINib**
      public func registerCellWithIdentifier(arrCustomCell:[BASReportCustomCell]) {
        self.arrCustomCell = arrCustomCell
          for customCell in arrCustomCell {
              self.tblReportSummary.register(customCell.0, forCellReuseIdentifier: customCell.1)
          }
          
      }
    
    //Reload UI
  public  func reloadData() {
        self.tblReportSummary.reloadData()
        self.colReportSummary.reloadData()
    }
    
    ///Reload Particular Column **COLUMN START FROM 0**
    public func reloadColumn(columnNo:Int) {
        let identifire = Array(arrGHeader.keys)[columnNo]
        if let tableView = arrTableView.first(where: {$0.accessibilityIdentifier == identifire}) {
            tableView.reloadData()
        }
    }
    
    ///Reload Particular Rows for ParticularColumn **Reload Rows for Column**
    public func reloadRowsForColumn(rows:[IndexPath] ,rowAnimation:UITableView.RowAnimation ,columnNo:Int) {
        let tableView = arrTableView[columnNo]
        tableView.reloadRows(at: rows, with: rowAnimation)
        
    }
    
   

}


extension BASCustomReport : UITableViewDataSource , UITableViewDelegate {
    
 
    public func numberOfSections(in tableView: UITableView) -> Int {
        if arrGHeader.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.layoutSettings.HEADER_SIZE
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.layoutSettings.CELL_SIZE
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let customHeaderDataSource = basReportHeaderDatasource {
            if arrCustomHeaderSectionForColumn.contains(0){
                return customHeaderDataSource.basReport(tableView, viewForHeaderInSection: section, column: 0)
            }
        }
        let cell:tblCellHeader = tableView.dequeueReusableCell(withIdentifier:"tblCellHeader" ) as! tblCellHeader
        cell.validateSelectedLabel = self.validateSelectedLabel
        cell.btnPlaceHolder.addTarget(self, action: #selector(btnSortingTapped(_:)), for: .touchUpInside)
        
        if arrGHeader.count > 0 {
            cell.configurePrimaryHeaderCell(headerTitle: Array(arrGHeader.keys)[section])
            cell.btnPlaceHolder.accessibilityHint = cell.lblHeaderName.text
        }
        cell.layoutPrimaryHeader(layoutSetting: self.layoutSettings)
        
        
        
        
        return cell
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReportSummaryDict.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customDataSource = basReportDatasource {
            if arrCustomIndexPathForColumn.contains(0){
                return customDataSource.basReport(tableView, cellForRowAt: indexPath, column: 0)
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblReportCell", for: indexPath) as! tblReportCell
        cell.selectionStyle = .none
        cell.imgReport.image = nil
        cell.lblReport.accessibilityIdentifier = "detail_label"

        cell.layoutPrimaryCell(layoutSetting: self.layoutSettings)
        if arrReportSummaryDict.count > 0 {
            let  key = Array(self.arrGHeader.keys)[0]
            if self.arrGHeader[key] == true {
                if let setImage = UIImage(named: (arrReportSummaryDict[indexPath.row][arrGKeys[0].0] as! String)) {
                    cell.lblReport.text = ""
                    cell.imgReport.image = setImage
                    cell.configurePrimaryReportDataImageAllignment(layoutSetting: self.layoutSettings)
                    
                } else {
                    cell.configurePrimaryReportData(reportTitle: (arrReportSummaryDict[indexPath.row][arrGKeys[0].0] as! String), needImage: self.arrGHeader)
                }
            } else {
            cell.configurePrimaryReportData(reportTitle: (arrReportSummaryDict[indexPath.row][arrGKeys[0].0] as! String), needImage: self.arrGHeader)
            }
            cell.lblReport.textAlignment = arrGKeys[0].1
            if arrGKeys[0].3 != nil {
                cell.contentView.backgroundColor = arrGKeys[0].3
            }
        }
     
       
            cell.lblReport.textColor = self.layoutSettings.PRIMARYREPORTDATA_TEXTCOLOR
        
        
        return cell
    }
    /*
     => sender.accessibilityLabel = set 1 or 2 (1 for ascending , 2 for Descending)
     => validateSelectedLabel.1 is Used to Set Image in 'ViewForHeader in SectionMethod'
     => let sorting = sender.accessibilityLabel?.getSorting() is Used for Get ComparisionResult [0.orderedAscending ||| 1..orderedDescending]
     => self.delegate?.selectedSorting..... Pass Data to ActualViewController Via DelegateMethod
     => self.validateSelectedLabel.0 = sender.accessibilityHint! is Set to Get Selected Header
     */
    @IBAction func btnSortingTapped(_ sender: UIButton) {
        guard let sortingDelegate = self.delegate else {return}
        guard let _ = sortingDelegate.selectedSorting?(sender: sender, BASReportView: self, sorting: .orderedSame) else {return}
        
        sender.accessibilityLabel = sender.accessibilityLabel?.toggleAccessibilityLabel()
        validateSelectedLabel.1 = sender.accessibilityLabel!
        guard let sorting = sender.accessibilityLabel?.getSorting() else {return}
        sortingDelegate.selectedSorting?(sender: sender, BASReportView: self, sorting: sorting)
        self.validateSelectedLabel.0 = sender.accessibilityHint!
        reloadData()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let firstRowDelegate = self.delegate else {return}
        firstRowDelegate.didSelectCellAt?(indexPath: indexPath, tableHint: tableView.accessibilityHint ?? "", basReport: self)
    }
    
   
    
}

extension BASCustomReport : UICollectionViewDataSource , UICollectionViewDelegate ,  UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrGHeader.keys.count - 1
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLSubReportDataCell", for: indexPath) as! CLSubReportDataCell
            
           // collectionView.dequeueReusableCell(withClass: CLSubReportDataCell.self, for: indexPath)
      
        cell.basCustomReport = self
        cell.registerCellWithIdentifier(arrCustomCell: self.arrCustomCell)
        cell.tblReportSummary.tag = indexPath.item + 1
        cell.tblReportSummary.accessibilityIdentifier = arrGHeader.keys[indexPath.item + 1]
        
        if let _ = arrTableView.first(where: {$0.accessibilityIdentifier == cell.tblReportSummary.accessibilityIdentifier}) {
            
        } else {
            self.arrTableView.append(cell.tblReportSummary)
        }
       
        cell.layoutSettings = self.layoutSettings
        cell.itemIndex = indexPath
        cell.validateSelectedLabel = self.validateSelectedLabel
        cell.arrReportSummaryDict = self.arrReportSummaryDict
        cell.tblReportSummary.accessibilityHint = arrGHeader.keys[indexPath.item + 1]
        cell.arrGHeader = self.arrGHeader
        cell.arrGKeys = self.arrGKeys
        cell.isSubCellClickable = self.isSubCellClickable
        cell.basReportDatasource = self.basReportDatasource
        cell.arrIndexPath = self.arrCustomIndexPathForColumn
        cell.basReportHeaderDatasource = self.basReportHeaderDatasource
        cell.arrCustomHeaderSectionForColumn = self.arrCustomHeaderSectionForColumn
        cell.delegate = self.delegate

        cell.tblReportSummary.reloadData()
        return cell
    }
    
    func totalWith() -> CGFloat {
        var count = 0
        var fixedWidth : CGFloat = 0.0
        var totalWidth: CGFloat = 0.0
        if self.arrGKeys.count > 0 {

            var tempHeader = self.arrGHeader.keys
            var tempKeys = self.arrGKeys
            tempHeader.removeFirst()
            tempKeys.removeFirst()
            tempHeader.enumerated().forEach { (index , header) in
                var width:CGFloat = 0.0
                let   key = header
                let fontAttributes = [NSAttributedString.Key.font: self.layoutSettings.SECONDARYHEADER_FONT]
                let size = (key as NSString).size(withAttributes: fontAttributes)
                width = 8 + size.width + 9 + 5  + 8 //Label Leading + Label Width + Leading from ImageView + 15 ImageView Width +  8 Trialing FromImageView
                
                if self.arrGKeys.count > 0 {
                    if tempKeys[index].2 != nil {
                        width = tempKeys[index].2!
                        fixedWidth = width + fixedWidth
                        count+=1
                        
                    }
                    totalWidth  = totalWidth + width
                }
                
            }
            totalWidth = totalWidth + self.tblReportSummary.frame.width
            //Store Full Width for devide calculation
            screen_Width_Calc = totalWidth
            if totalWidth < screenWidth {
                
                totalWidth = totalWidth - fixedWidth
            }
        }
        
        
        
        //count = count != 0 ? count : 1
        if count != 0 {
            return (screenWidth - self.tblReportSummary.frame.width)/CGFloat((arrGHeader.count-1) - count)
        } else {
            return (screenWidth - self.tblReportSummary.frame.width)/CGFloat(arrGHeader.count-1)
        }
    }
    
    func calculateOnlyHeaderWidth() -> CGFloat {
        
        let count = 0
        let fixedWidth : CGFloat = 0.0
        var totalWidth: CGFloat = 0.0
        var tempHeader = self.arrGHeader.keys
        if tempHeader.count > 0 {
            tempHeader.removeFirst()
            tempHeader.enumerated().forEach { (index , header) in
                var width:CGFloat = 0.0
                let   key = header
                let fontAttributes = [NSAttributedString.Key.font: self.layoutSettings.SECONDARYHEADER_FONT]
                let size = (key as NSString).size(withAttributes: fontAttributes)
                width = 8 + size.width + 9 + 5  + 8 //Label Leading + Label Width + Leading from ImageView + 15 Im
                totalWidth  = totalWidth + width
            }
            totalWidth = totalWidth + self.tblReportSummary.frame.width
            screen_Header_Width_Calc = totalWidth
            if totalWidth < screenWidth {
                
                totalWidth = totalWidth - fixedWidth
            }
        }
        
        if count != 0 {
        } else {
            return (screenWidth - self.tblReportSummary.frame.width)/CGFloat(arrGHeader.count-1)
        }
        //
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let calculatecWidth = totalWith()
        
        if self.arrGKeys.count > 0 {
            
            if screen_Width_Calc < screenWidth {
                if self.arrGKeys[indexPath.item + 1].2 != nil {
                    return  CGSize(width:self.arrGKeys[indexPath.item + 1].2! , height: collectionView.frame.height)
                }
                return CGSize(width:calculatecWidth , height: collectionView.frame.height)
            }
        }
        else {
            if arrGKeys.count == 0 {
                let calWidth = calculateOnlyHeaderWidth()
                 if screen_Header_Width_Calc < screenWidth {
                    return CGSize(width:calWidth , height: collectionView.frame.height)
                }
            }
        }
        
        var width:CGFloat = 0.0
        let   key = Array(arrGHeader.keys)[indexPath.item + 1]
        let fontAttributes = [NSAttributedString.Key.font: self.layoutSettings.SECONDARYHEADER_FONT]
        let size = (key as NSString).size(withAttributes: fontAttributes)
        width = 8 + size.width + 9 + 5  + 8 //Label Leading + Label Width + Leading from ImageView + 15 ImageView Width +  8 Trialing FromImageView
        
        if self.arrGKeys.count > 0 {
            if self.arrGKeys[indexPath.item + 1].2 != nil {
                width = self.arrGKeys[indexPath.item + 1].2!
            }
        }
        
        if self.validateSelectedLabel.0 != "" {
            if  validateSelectedLabel.0 == Array(arrGHeader.keys)[indexPath.item + 1] {
                width = width + 15
            }
        }
        
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.needToScroll(scrollView)
        
    }
    
    
    
    func needToScroll(_ scrollView: UIScrollView) {
        
        if scrollView.isKind(of: UITableView.self) {
            if arrTableView.count > 0 {
                for tableview in arrTableView {
                    let scrollView1 : UIScrollView = tableview
                    scrollView1.contentOffset = scrollView.contentOffset
                    
                }
            }
        }
        //self.layoutIfNeeded()
    }
}


