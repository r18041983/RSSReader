//
//  Utilities.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 29.03.2021.
//

import Foundation
import UIKit


func alerter(title: String?, message: String?) -> UIAlertController
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    return alert
}

func stringRSSToDate(dateString: String?) -> Date
{
    guard var dateString = dateString
    else
    {
        return Date.distantPast
    }
    dateString = dateString.trimmingCharacters(in: .whitespacesAndNewlines)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMMM yyyy HH:mm:ss Z"
    let date1 :Date? = dateFormatter.date(from: dateString)

    return date1 ?? Date.distantPast
}
