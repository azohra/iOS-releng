//
//  ArticleDetailsViewController.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-17.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {

    var viewModel : Article?
    @IBOutlet weak var titleText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Article Details"
        titleText.text = viewModel?.title
    }

}
