//
//  Article.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-10.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import Foundation

struct Article : Codable {
    let title : String?
    let thumbnail: String?
    let thumbnailWidth: Int?
    let thumbnailHeight: Int?
}
