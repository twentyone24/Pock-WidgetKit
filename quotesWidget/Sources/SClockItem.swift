//
//  SClockItem.swift
//  quotesWidget
//
//  Created by NAVEEN MADHAN on 3/14/23.
//

import Foundation
import AppKit
import TinyConstraints

internal class SClockItem: StatusItem {


    private var refreshTimer: Timer?
    private var clockLabel: NSTextField! = NSTextField(labelWithString: "…")

    init() {
    print("[Status]: init SClockItem")
        didLoad()
    }

    deinit {
        didUnload()
    print("[Status]: deinit SClockItem")
    }

    func didLoad() {
        if clockLabel == nil {
            clockLabel = NSTextField(labelWithString: "…")
        }
        clockLabel.font = NSFont.monospacedDigitSystemFont(ofSize: 13, weight: .regular)
        clockLabel.maximumNumberOfLines = 1
        reload()
      refreshTimer = Timer.scheduledTimer(timeInterval: 1, target: self, repeats: true, action: { [weak self] in
            self?.reload()
        })
    }

    func didUnload() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }

    var enabled: Bool { return true }
    var title: String { return "clock" }
    var view: NSView { return clockLabel }

    func action() {}

    @objc func reload() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EE dd MMM HH:mm"
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "en_US_POSIX")
        clockLabel?.stringValue = ""
        clockLabel?.stringValue = formatter.string(from: Date())
        clockLabel?.sizeToFit()
    }

}
