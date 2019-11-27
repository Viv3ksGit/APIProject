//
//  Article.swift
//  APIProject
//
//  Created by Anastasia Nesterenko on 2019-11-26.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import Foundation
import ObjectMapper

class Article : Mappable {
    var author: String? = ""
    var title: String? = ""
    var description: String? = ""
    var url: String? = ""
    var urlToImage: String? = ""
    var publishedAt: String? = ""
    var content: String? = ""
    
    required init?(map: Map){}
    
    func mapping(map: Map){
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
    }
}
