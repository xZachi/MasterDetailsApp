//
//  MasterTableViewController.swift
//  MasterDetailApp
//
//  Created by Swigut Jan, ITP-IP on 20/05/2019.
//  Copyright © 2019 Swigut Jan. All rights reserved.
//

import UIKit
import SDWebImage

protocol MasterCellSelectionDelegate: AnyObject {
    func cellSelected(_ something: MasterItem)
}

class MasterTableViewController: UITableViewController, UISplitViewControllerDelegate {

    // MARK: - Variables
    
    weak var delegate: MasterCellSelectionDelegate?
    var viewModel: MasterTableViewModel = MasterTableViewModel()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
        tableView.register(MasterTableViewCell.self, forCellReuseIdentifier: "masterCell")
        viewModel.fetchMasterItems { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.selectFirstRow()
            }
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            splitViewController?.preferredDisplayMode = .allVisible
        } else {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    // MARK: - Private Methods
    
    private func selectFirstRow() {
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: firstIndexPath, animated: false, scrollPosition: .top)
        if let firstCell = tableView.cellForRow(at: firstIndexPath) {
            firstCell.contentView.backgroundColor = .red
            firstCell.textLabel?.textColor = .white
        }
        let masterItem = viewModel.getMasterItemFor(firstIndexPath)
        delegate?.cellSelected(masterItem)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.getMasterItemsCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "masterCell", for: indexPath) as? MasterTableViewCell {
            let masterItem = viewModel.getMasterItemFor(indexPath)
            cell.item = masterItem
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let masterItem = viewModel.getMasterItemFor(indexPath)
        delegate?.cellSelected(masterItem)
        if let detailViewController = delegate as? DetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
}

