//
//  DetailViewController.swift
//  MasterDetailApp
//
//  Created by Swigut Jan, ITP-IP on 20/05/2019.
//  Copyright © 2019 Swigut Jan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    //MARK: - Variables
    
    var viewModel = DetailViewModel()
    
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.popViewController(animated: true)
    }
    
}


//MARK: - Extensions

extension DetailViewController : MasterCellSelectionDelegate {
    func cellSelected(_ something: MasterItem) {
        viewModel.setMasterItem(something)
    }
}

extension DetailViewController: DetailsViewModelDelegate {
    func detailsItemFetched(item: DetailsItem) {
        DispatchQueue.main.async {
            self.detailLabel.text = item.text
            if let imageLink = item.image {
                self.detailImageView.sd_setImage(with: URL(string: imageLink))
            }
        }
    }
}
