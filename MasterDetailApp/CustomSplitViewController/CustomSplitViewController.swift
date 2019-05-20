//
//  CustomSplitViewController.swift
//  MasterDetailApp
//
//  Created by Swigut Jan, ITP-IP on 20/05/2019.
//  Copyright © 2019 Swigut Jan. All rights reserved.
//

import Foundation

import UIKit

class CustomSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
}
