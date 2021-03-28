//
//  WaitIndicator.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 28.03.2021.
//

import Foundation
import UIKit

struct WaitIndicator
{
    static var shared = WaitIndicator()
    private init() {}
 
    private var isShow = false
    private var viewWithIndicator: UIView?
    
    mutating func show(viewToAdd: inout UIView)
    {
        if isShow {return}
        
        self.viewWithIndicator = UIView(frame: viewToAdd.bounds)
        self.viewWithIndicator?.backgroundColor = UIColor.clear
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        self.viewWithIndicator?.addSubview(indicator)
        indicator.startAnimating()
        indicator.center = self.viewWithIndicator!.center
        guard let _ = self.viewWithIndicator
        else {return}
        viewToAdd.addSubview(self.viewWithIndicator!)
        isShow = true
    }

    mutating func hide()
    {
        if !isShow {return}
        self.viewWithIndicator?.removeFromSuperview()
        self.viewWithIndicator = nil
        isShow = false
    }

}
