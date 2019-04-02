//
//  ArticlesViewController.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-09.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import UIKit

class ArticlesViewController: UIViewController {

    var viewModel : ArticleViewModelDelegate?
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    var articles : [Article] = []
    var cellDynamicHeight : [CGFloat] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        articlesTableView.accessibilityIdentifier = Constants.Screens.Articles.AccessibilityIdentifiers.articlesTableView
        articlesTableView.estimatedRowHeight = 100
    }

    func setViewModel(vm:ArticleViewModelDelegate){
        self.viewModel = vm
        
        viewModel?.articles.bind({ [weak self](articlesList) in
            self?.articles = articlesList
            self?.showArticles()
        })
        viewModel?.error.bind({ [weak self](error) in
            self?.showErrorMessage(error: error)
        })
        
        viewModel?.fetchArticles()
    }
    
    /*
     * Update current view with articles list and hide the error view if shown previously
     */
    func showArticles(){
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.calculateDynamicHeightForArticles()
            weakSelf?.articlesTableView.reloadData()
            weakSelf?.errorMessage.isHidden = true
            weakSelf?.articlesTableView.isHidden = false
        }        
    }
    
    /*
     * Hide the table view and show error information
     */
    func showErrorMessage(error:ResponseError){        
        weak var weakSelf = self
        DispatchQueue.main.async {
            weakSelf?.errorMessage.text = error.message
            weakSelf?.errorMessage.isHidden = false
            weakSelf?.articlesTableView.isHidden = true
        }
    }
    
    /*
     * Caclulates metadata that enables dynamic height for cells
     */
    func calculateDynamicHeightForArticles(){
        for i in 0..<articles.count{
            let targetHeight = getCellHeightForArticle(article: articles[i]) + CGFloat(20)
            cellDynamicHeight.insert(targetHeight, at: i)
        }
    }
    
    /*
     * Caclulate dynamic height for Article
     */
    func getCellHeightForArticle(article:Article)-> CGFloat{
        let height = CGFloat(article.thumbnailHeight ?? 0)
        let estimatedTextHeight = article.title?.heightWithConstrainedWidth(width: getConstrainedWidthForTitle(article: article) , font: Constants.Screens.Articles.Fonts.titleFont)
        return estimatedTextHeight! > height ? estimatedTextHeight! : height
    }
    
    
    func getConstrainedWidthForTitle(article:Article)->CGFloat{
        let defaultWidth = UIScreen.main.bounds.width - 30
        return article.thumbnailWidth == nil ? defaultWidth : defaultWidth - CGFloat(article.thumbnailWidth!)
    }
    
    
}
/*
 * Extension to handle UITableView delegate and datasource
 */
extension ArticlesViewController: UITableViewDelegate,UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(cellDynamicHeight[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.Screens.Articles.CellIdentifiers.articleCell, for: indexPath) as! ArticleTableViewCell
        let article : Article = articles[indexPath.row]
        cell.setupCell(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.StoryboardIdentifier.articleDetail) as! ArticleDetailsViewController
        vc.viewModel = articles[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

