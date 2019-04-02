//
//  RedditJsonModel.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-12.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import Foundation

struct RedditJsonModel : Codable {
    let data : RedditData?
}

struct RedditData : Codable{
    let children : [Children]?
}

struct Children : Codable {
    let data : ChildrenData?

}

struct ChildrenData : Codable {
    let title : String?
    let thumbnail : String?
    let thumbnail_height:Int?
    let thumbnail_width:Int?
}
