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
import TinyConstraints

extension NSImage {
  /// Returns an NSImage snapshot of the passed view in 2x resolution.
  convenience init?(frame: NSRect, view: NSView) {
    guard let bitmapRep = view.bitmapImageRepForCachingDisplay(in: frame) else {
      return nil
    }
    self.init()
    view.cacheDisplay(in: frame, to: bitmapRep)
    addRepresentation(bitmapRep)
    bitmapRep.size = frame.size
  }
}

class quotesWidget: PKWidget {
    
    static var identifier: String = "com.widget.quotesWidget"
    var customizationLabel: String = "quotesWidget"


  var view: NSView!

  private var stackView: NSStackView {
    return view as! NSStackView
  }
  private var loadedItems: [StatusItem] = []

  var imageForCustomization: NSImage {
    let stackView = NSStackView(frame: .zero)
    stackView.orientation = .horizontal
    stackView.alignment = .centerY
    stackView.distribution = .fill
    stackView.spacing = 8

      stackView.addArrangedSubview(SClockItem().view)

    return NSImage(frame: NSRect(origin: .zero, size: stackView.fittingSize), view: stackView) ?? NSImage()
  }

  func prepareForCustomization() {
    clearItems()
  }

    required init() {
    view = NSStackView(frame: .zero)
    stackView.orientation = .horizontal
    stackView.alignment = .centerY
    stackView.distribution = .fill
    stackView.spacing = 8
    }

    deinit {
    clearItems()
    }

    func viewDidAppear() {
    loadStatusElements()
    NotificationCenter.default.addObserver(self, selector: #selector(loadStatusElements), name: .shouldReloadStatusWidget, object: nil)
    }

    func viewWillDisappear() {
        clearItems()
    NotificationCenter.default.removeObserver(self)
    }

  private func clearItems() {
    for view in stackView.arrangedSubviews {
      stackView.removeArrangedSubview(view)
      view.removeFromSuperview()
    }
    for item in loadedItems {
      item.didUnload()
    }
    loadedItems.removeAll()
  }

    @objc private func loadStatusElements() {
    clearItems()

      let item = SClockItem()
      loadedItems.append(item)
      stackView.addArrangedSubview(item.view)

    stackView.height(30)
    }
    
}

extension NSNotification.Name {
    static let shouldReloadStatusWidget = NSNotification.Name("shouldReloadStatusWidget")
}
