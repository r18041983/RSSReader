//
//  ViewController.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 24.03.2021.
//

import UIKit
import CryptoKit

class NewsViewController: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var parseButton: UIButton!
    @IBOutlet weak var newsTableView: UITableView!
    
    var URLString = "https://lenta.ru/rss"
    
    var postsArray = [Dictionary<String, String>]()
    let reuseIdentifier = "NewsTableCell"
    let segueIdentifier = "fromTableNewsToTextNews"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.newsTableView.register(UINib(nibName: "NewsTableCell", bundle: nil), forCellReuseIdentifier: self.reuseIdentifier)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segueIdentifier == self.segueIdentifier,
           let cell = sender as? NewsTableCell,
           let destination = segue.destination as? ShowPostController
        {
            destination.setPostParameters(data: cell.savedData, title: cell.savedTitle, text: cell.savedText, link: cell.savedLink)
        }
    }
    
    
    func sortByData(operation: Character) {
        
        for _ in 0..<self.postsArray.count
        {
            var flagNoChanges = true
            for index in 0..<(self.postsArray.count - 1)
            {
                let date1 = stringRSSToDate(dateString: self.postsArray[index]["pubDate"])
                let date2 = stringRSSToDate(dateString: self.postsArray[index + 1]["pubDate"])
                
                var boolSignature = true
                if operation == ">"
                {
                    boolSignature = date1 > date2
                }
                else if operation == "<"
                {
                    boolSignature = date1 < date2
                }
                
                if boolSignature
                {
                    let tempPost = self.postsArray[index]["pubDate"]
                    self.postsArray[index]["pubDate"] = self.postsArray[index + 1]["pubDate"]
                    self.postsArray[index + 1]["pubDate"] = tempPost
                    flagNoChanges = false
                }
            }
            if flagNoChanges
            {
                break
            }
        }
    }
    
    

    @IBAction func pressParseButton(_ sender: UIButton)
    {
        guard let link = self.addressTextField.text
        else
        {
            return
        }
        self.URLString = link
        let parserRSSLenta = RSSParser(urlString: link)
        parserRSSLenta.delegate = self
        parserRSSLenta.parseRSS()
    }

}

extension NewsViewController: RSSParserDelegate
{
    func beginParsing(parser: RSSParser)
    {
        DispatchQueue.main.async
        {
            WaitIndicator.shared.show(viewToAdd: &self.view)
        }
    }
    
    func newPost(parser: RSSParser, postDict: Dictionary<String, String>)
    {
        self.postsArray.append(postDict)
    }
    
    func endParsing(parser: RSSParser)
    {
        self.sortByData(operation: ">")
        DispatchQueue.main.async
        {
            WaitIndicator.shared.hide()
            self.newsTableView.reloadData()
        }
    }
    
    func parseErrorOccurred(parser: RSSParser, parseError: ParserError)
    {
        DispatchQueue.main.async
        {
            WaitIndicator.shared.hide()
            self.present(alerter(title: "Error", message: parseError.rawValue), animated: true)
        }
    }
    
    
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as? NewsTableCell else {return UITableViewCell()}
        
        let post = self.postsArray[indexPath.row]
        cell.setNewsCellParameters(data: post["pubDate"], title: post["title"], text: post["description"], link: post["link"])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableCell
        else {return}
        performSegue(withIdentifier: self.segueIdentifier, sender: cell)
    }
    
}
