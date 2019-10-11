//
//  BASCustomReport.swift
//  BASCustomReport
//
//  Created by Uffizio iMac2 on 08/05/19.
//  Copyright © 2019 Uffizio. All rights reserved.
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

public class BASCustomReport: UIView {

    /// All UIRelated Setting -> Headercolor , seperator Color , HeaderSize , SeperatorSize Bla Bla
    public  var layoutSettings = BASReportLayout()
    //Outlets
    @IBOutlet weak var tblReportSummary: UITableView!
    @IBOutlet weak public var colReportSummary: UICollectionView!
    @IBOutlet weak private var vwBackup: UIView!
    @IBOutlet weak public var delegate:BASReportDeleate?
    @IBOutlet weak private var lblNoRecordFound: UILabel!
    /// if you want to make 1st cell Clickable
    public var isClikable = false
    
    /// If you want to make other cell Clickable(except 1st cell)
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
   open var arrGHeader = OrderedDictionary<String, Bool>()
    /// 0.is Dictionary Keys(Json Webservice Keys) 1. is Text Allignment(Left , Right , Center) to display Text 2.Custom CellWidth of Column 3.Custom BackGroundColor of Particular cell
   public var arrGKeys = [keysAndAllignment]()
    /// .0 is for identify selected Header and .1 get current sorting for that Header(ascending and Descending)
   public var validateSelectedLabel = ("","")
    /// Maintain the Scroll For All View
    var arrTableView = [UITableView]()
    
    
    //Initial Setup
    var view: UIView!
    
    /// store global calculated width
    var screen_Width_Calc:CGFloat = 0.0

    
    
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
    func registerCells() {
        self.lblNoRecordFound.font = layoutSettings.NODATA_FONT
        self.lblNoRecordFound.textColor = layoutSettings.NODATA_TEXTCOLOR
        tblReportSummary.register(UINib(nibName: "tblCellHeader", bundle: Bundle(identifier: BASREPORT_BUNDLE_ID)), forCellReuseIdentifier: "tblCellHeader")
        tblReportSummary.register(UINib(nibName: "tblReportCell", bundle: Bundle(identifier: BASREPORT_BUNDLE_ID)), forCellReuseIdentifier: "tblReportCell")
        colReportSummary.register(UINib(nibName: "CLSubReportDataCell", bundle: Bundle(identifier: BASREPORT_BUNDLE_ID)), forCellWithReuseIdentifier: "CLSubReportDataCell")
        self.tblReportSummary.tag = 0
        self.arrTableView.append(self.tblReportSummary)
        
       
        
        //YourCollectionView.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft

    }
    
    //Reload UI
  public  func reloadData() {
   
        
        self.tblReportSummary.reloadData()
        self.colReportSummary.reloadData()
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
        let cell:tblCellHeader = tableView.dequeueReusableCell(withIdentifier:"tblCellHeader" ) as! tblCellHeader
       // let cell:tblCellHeader = tableView.dequeueReusableCell(withIdentifier: "tblCellHeader") as! tblReportCell//tableView.dequeueReusableCell(withClass: tblCellHeader.self)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblReportCell", for: indexPath) as! tblReportCell
        cell.selectionStyle = .none

        cell.layoutPrimaryCell(layoutSetting: self.layoutSettings)
        if arrReportSummaryDict.count > 0 {
            cell.configurePrimaryReportData(reportTitle: (arrReportSummaryDict[indexPath.row][arrGKeys[0].0] as! String))
            cell.lblReport.textAlignment = arrGKeys[0].1
            if arrGKeys[0].3 != nil {
                cell.contentView.backgroundColor = arrGKeys[0].3
            }
        }
        if isClikable == true {
            cell.lblReport.textColor = self.layoutSettings.isClikableColor
        } else {
            cell.lblReport.textColor = self.layoutSettings.PRIMARYREPORTDATA_TEXTCOLOR
        }
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
        if self.delegate != nil {
        sender.accessibilityLabel = sender.accessibilityLabel?.toggleAccessibilityLabel()
        validateSelectedLabel.1 = sender.accessibilityLabel!
        let sorting = sender.accessibilityLabel?.getSorting()
        self.delegate?.selectedSorting!(sender: sender, BASReportView: self, sorting: sorting!)
        self.validateSelectedLabel.0 = sender.accessibilityHint!
        reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.getIndexPath?(indexPath: indexPath, basReport: self)
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
        cell.tblReportSummary.tag = indexPath.item + 1
        if !self.arrTableView.contains(cell.tblReportSummary) {
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
        cell.delegate = self.delegate

        cell.tblReportSummary.reloadData()
        return cell
    }
    
    func totalWith() -> CGFloat {
      
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
                           
                         }
                             totalWidth  = totalWidth + width
                         }
                         
        }
         totalWidth = totalWidth + screenWidth/2
        //Store Full Width for devide calculation
        screen_Width_Calc = totalWidth
        if totalWidth < screenWidth {
            totalWidth = totalWidth/CGFloat(tempHeader.count)
        }
        }
        return totalWidth
       
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let calculatecWidth = totalWith()
        
         if self.arrGKeys.count > 0 {
        if self.arrGKeys[indexPath.item + 1].2 != nil {
                   return  CGSize(width:self.arrGKeys[indexPath.item + 1].2! , height: collectionView.frame.height)
        }
        }
        if screen_Width_Calc < screenWidth {
            return CGSize(width:calculatecWidth , height: collectionView.frame.height)
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

