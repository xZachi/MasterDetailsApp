//
//  MasterTableViewModel.swift
//  MasterDetailApp
//
//  Created by Swigut Jan, ITP-IP on 20/05/2019.
//  Copyright © 2019 Swigut Jan. All rights reserved.
//

import Foundation

class MasterTableViewModel {
    
    //MARK: - Variables
    
    private var masterItems = [MasterItem]()
    
    //MARK: - Methods
    
    func fetchMasterItems(successHandler: @escaping() -> ()) {
        dataRequest(with: "http://dev.tapptic.com/test/json.php", objectType: [MasterItem].self) { (result: Result) in
            switch result {
            case .success(let object):
                self.masterItems = object
                successHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMasterItemsCount() -> Int {
        return masterItems.count
    }
    
    func getMasterItemFor(_ indexPath: IndexPath) -> MasterItem {
        return masterItems[indexPath.row]
    }
    
}
