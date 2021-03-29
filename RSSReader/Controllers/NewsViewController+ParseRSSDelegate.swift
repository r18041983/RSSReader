//
//  NewsViewController+ParseRSSDelegate.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 29.03.2021.
//

import Foundation
import UIKit

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
        self.sortByData(operation: self.sortOperation)
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
