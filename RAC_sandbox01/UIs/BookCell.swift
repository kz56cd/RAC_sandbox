//
//  BookCell.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/17.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!

    private var bookCellModel: BookCellModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with cellModel: BookCellModel) {
        bookCellModel = cellModel
        titleLabel.text = bookCellModel?.title
        publisherLabel.text = bookCellModel?.publisher
    }
}
