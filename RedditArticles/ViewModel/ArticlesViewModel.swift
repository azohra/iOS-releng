//
//  ArticlesViewModel.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-10.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import Foundation

/*
 * Subscriber/Listener implementation using generics
 */
class Dynamic<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}


protocol ArticleViewModelDelegate{
    var articles : Dynamic<[Article]> {get set}
    var error : Dynamic<ResponseError> {get set}
    func fetchArticles()
    func parseModel(model:RedditJsonModel)
    
}

class ArticlesViewModel : ArticleViewModelDelegate{
    var articles: Dynamic<[Article]>
    var error: Dynamic<ResponseError>

    let modelController : ArticlesModelDelegate?

    init(modelService:ArticlesModelDelegate) {
        modelController = modelService
        articles = Dynamic([])
        error = Dynamic(ResponseError(message: nil, type: nil))
    }
    
    
    /*
     *  trigger the initial fetch call for articles
     */
    func fetchArticles() {
        modelController?.fetchArticles { (response) in
            switch response {
            case .Success(data: let redditModel):
                self.parseModel(model: redditModel)
            case .Failure(error: let responseError):
                self.error.value = responseError
            }
        }
    }
    
    /*
     Convert json model to view models
     */
    func parseModel(model:RedditJsonModel){
        var articles : [Article] = []
        guard let children = model.data?.children else {
            self.articles.value = articles
            return
        }
        for child in children{
            let article = Article(title: child.data?.title, thumbnail: child.data?.thumbnail, thumbnailWidth: child.data?.thumbnail_width, thumbnailHeight: child.data?.thumbnail_height)
            articles.append(article)
        }
        self.articles.value = articles
    }
    
}


