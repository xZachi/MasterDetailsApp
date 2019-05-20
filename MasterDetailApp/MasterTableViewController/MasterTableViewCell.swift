//
//  MasterTableViewCell.swift
//  MasterDetailApp
//
//  Created by Swigut Jan, ITP-IP on 20/05/2019.
//  Copyright © 2019 Swigut Jan. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {

    // MARK: - Variables
    
    var item: MasterItem? { didSet {
            setContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = .red
            textLabel?.textColor = .white
        } else {
            contentView.backgroundColor = .white
            textLabel?.textColor = .black
        }
    }
    
    //MARK: - Private Methods
    
    private func setContent() {
        textLabel?.text = "\(item?.name ?? "")"
        if let imageLink = item?.image {
            imageView?.sd_setImage(with: URL(string: imageLink), completed: { (_, _, _, _) in
                self.setNeedsLayout()
            })
        }
    }

}
