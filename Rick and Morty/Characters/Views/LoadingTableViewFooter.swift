//
//  LoadingTableViewFooter.swift
//  Rick and Morty
//
//  Created by Kalil Holanda on 15/10/20.
//

import UIKit

class LoadingTableViewFooter: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        
        style = .large
        color = .purple
        startAnimating()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
