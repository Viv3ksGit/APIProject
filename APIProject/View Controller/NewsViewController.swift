//
//  NewsViewController.swift
//  APIProject
//
//  Created by Jeffrey Neil Dsouza on 2019-11-21.
//  Copyright © 2019 com.vivekmohanan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class NewsViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var newsTextView: UITextView!
    
    var query = "", url = ""
    var arrayNews = [Article]()
    var date: String = ""
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        getNews()
    }
    
    func getNews()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.string(from: Date())
        
        url = "https://newsapi.org/v2/everything?"
        url +=  !query.isEmpty ? query :"qInTitle=a"
        url +=  "&from=" + date + "&to=" + date + "&sortBy=popularity&apiKey=7358ac4243ed4380a540374e391ae43f"
        loadNews(url, completionHandler: { (success) -> Void in
            if success {
                self.updateNews()
            } else {
                print("Error")
            }
        })
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        query = "qInTitle="+(searchBar.text!.trimmingCharacters(in: .whitespaces).components(separatedBy: [" "]).joined(separator: "%20OR%20"))
        getNews()
    }
    
    func updateNews(){
        self.newsTextView.attributedText = NSAttributedString(string: "")
        for article in self.arrayNews {
            let title = article.title ?? ""
            let author = article.author != nil ? " by " + article.author! + "\n\n" : ""
            
            let attributedText = NSMutableAttributedString(attributedString: self.newsTextView.attributedText)
            attributedText.append(NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: UIColor.white]))
            attributedText.append(NSAttributedString(string: author, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.lightText]))
            self.newsTextView.attributedText = attributedText
        }
    }
    
    func loadNews(_ url: String, completionHandler: @escaping CompletionHandler) {
        Alamofire.request(url).responseArray(keyPath: "articles") { (response: DataResponse<[Article]>) in
            if let articlesArray = response.result.value {
                self.arrayNews = articlesArray
                completionHandler(true)
            }
            else {print(url, response.result.error.debugDescription)}
        }
    }
}
