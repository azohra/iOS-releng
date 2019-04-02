//
//  ArticleTableViewCell.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-16.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var thumbnailWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    /*
     * Setup cell with article info
     */
    func setupCell(article:Article){
        title.text = article.title
        guard let url = article.thumbnail,let width = article.thumbnailWidth,let height = article.thumbnailHeight else{
            thumbnail.frame = CGRect.zero
            thumbnailWidthConstraint.constant = thumbnail.frame.width
            self.layoutIfNeeded()
            return
        }
        thumbnail.frame = CGRect(x: thumbnail.frame.origin.x, y: thumbnail.frame.origin.y, width: CGFloat(width), height: CGFloat(height))
        thumbnailWidthConstraint.constant = thumbnail.frame.width
        thumbnail.setThumbnailImage(URL(string: url))
    }
}

