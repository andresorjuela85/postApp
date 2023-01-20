//
//  Loader.swift
//  postApp
//
//  Created by Andres Orjuela on 18/01/23.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    var activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        activityIndicator.color = .black
        self.addSubview(activityIndicator)
    }
}

extension UIViewController {
    
    func showLoader() {
        
        let loaderView = LoaderView.init(frame: view.bounds)
        loaderView.backgroundColor = .white
        
        DispatchQueue.main.async {
            self.view.addSubview(loaderView)
        }
    }
    
    func removeLoader () {
        
        if let loaderView = self.view.subviews.last, loaderView.isKind(of: LoaderView.self) {
            
            DispatchQueue.main.async {
                loaderView.removeFromSuperview()
            }
        }
    }
}
