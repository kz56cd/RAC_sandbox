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
    
    private var book: Book?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func glueData(book: Book) {
        self.book = book
        titleLabel.text = book.title
        publisherLabel.text = book.publisher
    }
    
    func getLink() -> URL? {
        guard let book = book,
            let urlStr: String = book.link else {
                return URL(string: "")
        }
        return URL(string: urlStr)
    }
}
