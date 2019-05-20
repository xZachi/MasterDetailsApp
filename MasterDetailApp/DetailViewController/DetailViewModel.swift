//
//  DetailViewModel.swift
//  MasterDetailApp
//
//  Created by Swigut Jan, ITP-IP on 20/05/2019.
//  Copyright © 2019 Swigut Jan. All rights reserved.
//

import Foundation

protocol DetailsViewModelDelegate: AnyObject {
    func detailsItemFetched(item: DetailsItem)
}

class DetailViewModel {
    
    //MARK: - Variables
    
    weak var delegate: DetailsViewModelDelegate?
    private var masterItem: MasterItem?
    private var detailsItem: DetailsItem?
    
    //MARK: - Methods
    
    func setMasterItem(_ item: MasterItem) {
        masterItem = item
        updateDetails()
    }
    
    func getDetailsItem() -> DetailsItem? {
        return detailsItem
    }
    
    //MARK: - Private Methods
    
    private func updateDetails() {
        fetchDetailsItem(succesHandler: { [weak self] in
            guard let detailsItem = self?.detailsItem else { return }
            self?.delegate?.detailsItemFetched(item: detailsItem)
        })
    }
    
    private func fetchDetailsItem(succesHandler: @escaping () -> ()) {
        guard let name = masterItem?.name else { return }
        let url = "http://dev.tapptic.com/test/json.php?name=\(name)"
        dataRequest(with: url, objectType: DetailsItem.self) { (result: Result) in
            switch result {
            case .success(let object):
                self.detailsItem = object
                succesHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
