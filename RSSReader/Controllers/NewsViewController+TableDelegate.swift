//
//  NewsViewController+TableDelegate.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 29.03.2021.
//

import Foundation
import UIKit

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsTableCell
        else {return}
        performSegue(withIdentifier: self.segueIdentifier, sender: cell)
    }
    
}
