//
//  ViewController.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 24.03.2021.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var parseButton: UIButton!
    @IBOutlet weak var newsTableView: UITableView!
    
    var URLString = "https://lenta.ru/rss"
    
    var postsArray = [Dictionary<String, String>]()
    let reuseIdentifier = "NewsTableCell"
    let segueIdentifier = "fromTableNewsToTextNews"
    var sortOperation: Character = "<"
    
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
