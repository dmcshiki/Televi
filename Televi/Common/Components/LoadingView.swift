//
//  LoadingView.swift
//  Televi
//
//  Created by Daniel McCarthy on 28/02/23.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        alpha = 0.5
        layer.cornerRadius = 10
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .lightGray
        activityIndicatorView.startAnimating()
        
        addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
