//
//  ArticlesModelController.swift
//  RedditArticles
//
//  Created by Muddsar Butt on 2018-10-10.
//  Copyright © 2018 Muddsar Butt. All rights reserved.
//

import Foundation


typealias ResponseHandler = (Response)->Void

enum ErrorType {
    case noData
    case noNetwork
    case apiFailure
    case parsingError
}

struct ResponseError {
    let message : String?
    let type : ErrorType?
}

enum Response {    
    case Success(data:RedditJsonModel)
    case Failure(error:ResponseError)
}


protocol ArticlesModelDelegate {
    func fetchArticles(handler: @escaping ResponseHandler)
}


class ArticlesModelController: ArticlesModelDelegate {
    
    let reachabilityManager : ReachabilityDelegate
    let sessionManager : URLSession
    
    init(reachability:ReachabilityDelegate,session:URLSession) {
        reachabilityManager = reachability
        sessionManager = session
    }
    
    /*
     * makes an request to reddit api to fetch the json data which is mapped to RedditJsonModel
     */
    func fetchArticles(handler: @escaping ResponseHandler){
        //check if internet connection is available to make api request
        if !reachabilityManager.isConnectedToNetwork(){
            handler(Response.Failure(error: ResponseError(message: Constants.ErrorMessages.noNetwork, type: ErrorType.noNetwork)))
            return
        }
        let redditURL = URL(string: Constants.URLs.redditArticlesJsonURL)!        
        sessionManager.dataTask(with: redditURL) { (data, response
            , error) in
                if error != nil {
                    handler(Response.Failure(error: ResponseError(message: error?.localizedDescription, type: ErrorType.apiFailure)))
                }else{
                    let httpResponse = response as? HTTPURLResponse
                    if httpResponse?.statusCode == Constants.StatusCodes.httpResponseSuccess {
                        if data != nil {
                            do {
                                let decoder = JSONDecoder()
                                let redditModel = try decoder.decode(RedditJsonModel.self, from: data!)
                                handler(Response.Success(data:redditModel))
                                
                            } catch let err {
                                handler(Response.Failure(error: ResponseError(message: err.localizedDescription, type: ErrorType.parsingError)))
                            }
                        }else{
                            handler(Response.Failure(error: ResponseError(message: Constants.ErrorMessages.noData, type: ErrorType.noData)))
                        }
                    }else{
                        handler(Response.Failure(error: ResponseError(message: error?.localizedDescription, type: ErrorType.apiFailure)))
                    }
                }
            }.resume()
    }
    
}
