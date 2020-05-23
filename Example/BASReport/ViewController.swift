//
//  ViewController.swift
//  BASReport
//
//  Created by badalpub1991@gmail.com on 10/10/2019.
//  Copyright (c) 2019 badalpub1991@gmail.com. All rights reserved.
//

import UIKit
import BASReport

class ViewController: UIViewController {
    
    
   
    
    //Outlets
     @IBOutlet weak var tblView: UITableView!
    
    //Variables
    var arrListData = ["BASReport NormalView" , "BASReport With Few Modifications" , "BASReport With Image and Text" , "BASReport with CustomCell" ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BASReport Example"
      
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = arrListData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewController = UIViewController()
        if indexPath.row == 0 {
            viewController = storyboard!.get(BASReportDefault.self)!
        }
        if indexPath.row == 1 {
            viewController = storyboard!.get(BASReportWithModifications.self)!
        }
        if indexPath.row == 2 {
            viewController = storyboard!.get(BASReportWithImage.self)!
        }
        if indexPath.row == 3 {
            viewController = storyboard!.get(BASReportWithCustomCell.self)!
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
  
}

extension UIStoryboard {
    
    /// Get view controller from storyboard by its class type
    /// Usage: let profileVC = storyboard!.get(ProfileViewController.self) /* profileVC is of type ProfileViewController */
    /// Warning: identifier should match storyboard ID in storyboard of identifier class
    public func get<T:UIViewController>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        
        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            return nil
        }
        
        return viewController
    }
    
    
}

