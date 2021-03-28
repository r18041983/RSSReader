//
//  ViewController.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 24.03.2021.
//

import UIKit
import CryptoKit

class ViewController: UIViewController {

    var URLString = "https://lenta.ru/rss"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    func MD5(string: String) -> String
    {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
        return digest.map
        {
            String(format: "%02hhx", $0)
        }.joined()
    }


    @IBAction func pressParseButton(_ sender: UIButton) {
        let parserRSSLenta = RSSParser(urlString: "https://lenta.ru/rss")
        parserRSSLenta.delegate = self
        parserRSSLenta.parseRSS()
    }

}

extension ViewController: RSSParserDelegate
{
    func beginParsing(parser: RSSParser)
    {
        print("begin")
    }
    
    func newPost(parser: RSSParser, postDict: Dictionary<String, String>)
    {
        print("new post")
        print(postDict)
    }
    
    func endParsing(parser: RSSParser)
    {
        print("finish")
    }
    
    func parseErrorOccurred(parser: RSSParser, parseError: Error)
    {
        print("Error")
        print(parseError)
    }
    
    
    
}
