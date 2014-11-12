//
//  ContentController.swift
//  sliding-menu-test-with-container
//
//  Created by Kyle Smyth on 2014-11-12.
//  Copyright (c) 2014 Kyle Smyth. All rights reserved.
//

import UIKit

class ContentController: UIViewController {

    var _content : UIViewController!
    
    func initContent(content: UIViewController) {
        _content = content
        self.addChildViewController(_content)
        _content.didMoveToParentViewController(self)
        self.view.addSubview(_content.view)
        _content.view.frame = self.view.bounds
    }
    
    func setContent(content : UIViewController) {
        if(content != _content) {
            if((_content) != nil) {
                _content.view.removeFromSuperview()
                _content.willMoveToParentViewController(nil)
                _content.removeFromParentViewController()
            }
            
            _content = content
            
            if((_content) != nil) {
                self.addChildViewController(_content)
                _content.didMoveToParentViewController(self)
                self.view.addSubview(_content.view)
                _content.view.frame = self.view.bounds
            }
        }
        
    }
    

}
