//
//  quotesWidget.swift
//  quotesWidget
//
//  Created by NAVEEN MADHAN on 3/14/23.
//  
//

import Foundation
import AppKit
import PockKit

class quotesWidget: PKWidget {
    
    static var identifier: String = "com.widget.quotesWidget"
    var customizationLabel: String = "quotesWidget"
    var view: NSView!
    
    required init() {
        self.view = PKButton(title: "quotesWidget", target: self, action: #selector(printMessage))
    }
    
    @objc private func printMessage() {
        NSLog("[quotesWidget]: Hello, World!")
    }
    
}
