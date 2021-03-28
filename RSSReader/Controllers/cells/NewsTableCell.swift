//
//  NewsTableCell.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 29.03.2021.
//

import UIKit

class NewsTableCell: UITableViewCell
{

    @IBOutlet var dataLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textPostLabel: UILabel!
    
    var savedLink: String?
    var savedData: String?
    var savedTitle: String?
    var savedText: String?
    
 
    func cleanAllCellValues()
    {
        self.dataLabel.text = ""
        self.titleLabel.text = ""
        self.textPostLabel.text = ""
        self.savedLink = nil
        self.savedData = nil
        self.savedTitle = nil
        self.savedText = nil
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        cleanAllCellValues()
    }
    
    
    override func prepareForReuse()
    {
        cleanAllCellValues()
    }
    
    
    func setNewsCellParameters(data: String?, title: String?, text: String?, link: String?)
    {
        if let data = data
        {
            self.dataLabel.text = data.trimmingCharacters(in: .whitespacesAndNewlines)
            self.savedData = data
        }
        if let title = title
        {
            self.titleLabel.text = title.trimmingCharacters(in: .whitespacesAndNewlines)
            self.savedTitle = title
        }
        if let text = text
        {
            self.textPostLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            self.savedText = text
        }
        if let link = link
        {
            self.savedLink = link
        }
    }
    
}
