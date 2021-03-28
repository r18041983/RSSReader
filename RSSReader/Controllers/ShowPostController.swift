//
//  ShowPostController.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 29.03.2021.
//

import UIKit

class ShowPostController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var openInBrowserButton: UIBarButtonItem!
    
    private var savedLink: String?
    private var savedData: String?
    private var savedTitle: String?
    private var savedText: String?
  
    
    func setPostParameters(data: String?, title: String?, text: String?, link: String?)
    {
        self.savedData = data
        self.savedTitle = title
        self.savedText = text
        self.savedLink = link
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if let link = self.savedLink
        {
            self.openInBrowserButton.isEnabled = true
            self.savedLink = link.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        else
        {
            self.openInBrowserButton.isEnabled = false
        }
        
        if let data = self.savedData
        {
            self.dataLabel.text = data.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let title = self.savedTitle
        {
            self.titleLabel.text = title.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let text = self.savedText
        {
            self.postTextView.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    

    @IBAction func pressOpenInBrowser(_ sender: UIBarButtonItem)
    {
        if let link = self.savedLink,
           let url = URL(string: link)
        {
            if UIApplication.shared.canOpenURL(url)
            {
                UIApplication.shared.open(url, options: [:])
            }
            else
            {
                self.present(alerter(title: "Error", message: "cannot open browser"), animated: true)
            }
        }
        else
        {
            self.present(alerter(title: "Error", message: "cannot open this link"), animated: true)
        }
    }
    
}
