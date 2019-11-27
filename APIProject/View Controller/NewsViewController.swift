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
    
    @IBOutlet weak var newsTableView: UITableView!
    var query = "", url = ""
    var arrayNews = [Article]()
    var date: String = ""
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        getNews()
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    func getNews() {
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
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        query = "qInTitle="+(searchBar.text!.trimmingCharacters(in: .whitespaces).components(separatedBy: [" "]).joined(separator: "%20OR%20"))
        getNews()
    }
    
    func updateNews() {
        self.newsTableView.reloadData()
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
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print("opening \(URL)")
        UIApplication.shared.open(URL)
        return false
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: "NewsCell")
        if !arrayNews.isEmpty {
        if let labelTitle = newsCell?.contentView.viewWithTag(110) as? UILabel {
            labelTitle.text = arrayNews[indexPath.row].title
            labelTitle.numberOfLines = 0
            labelTitle.sizeToFit()
        }
        if let labelAuthor = newsCell?.contentView.viewWithTag(111) as? UILabel {
                   labelAuthor.text = arrayNews[indexPath.row].author
               }
        }
        return newsCell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let strAttributesMs = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:16.0)]
        let alrtMessage = NSMutableAttributedString(string: arrayNews[indexPath.row].description!, attributes: strAttributesMs)
        let alert = UIAlertController(title: arrayNews[indexPath.row].title, message: "", preferredStyle: .alert)
        alert.setValue(alrtMessage, forKey: "attributedMessage")

        let goAction = UIAlertAction(title: "Read more", style: .default) {
             UIAlertAction in
            UIApplication.shared.open(URL(string: self.arrayNews[indexPath.row].url!)!)
         }
        alert.addAction(goAction)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
