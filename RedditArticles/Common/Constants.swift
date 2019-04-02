//
//  Constants.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-12.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    //struct to list all the url string
    struct URLs {
        static let redditArticlesJsonURL : String = "https://www.reddit.com/r/swift.json"
    }
    //struct to list the specific response codes
    struct StatusCodes {
        static let httpResponseSuccess = 200
        static let httpResponseFail = 500
    }
    //struct to list custom error messages
    struct ErrorMessages {
        static let noData = "No Data Found"
        static let noNetwork = "Please check your internet settings."
    }
    
    struct StoryboardIdentifier {
        static let articleDetail = "articleDetailView"
    }
    
    
    
    struct Screens {
        struct Articles {
            struct AccessibilityIdentifiers {
                static let articlesTableView = "articlesTableView"
            }
            struct CellIdentifiers {
                static let articleCell = "articleCell"
            }
            struct Fonts {
                static let titleFont = UIFont.systemFont(ofSize: 17)
            }
        }
        struct ArticleDetails {
            struct AccessibilityIdentifiers {
                static let titleLabel = "articleTitle"
            }
        }
    }
    
    
    
}
