//
//  AppDelegate.swift
//  TextTransformer
//
//  Created by Mohamed Kelany on 10/25/20.
//  Copyright © 2020 Mohamed Kelany. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "𝑎"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @objc func showSettings() {
        let storyboard = NSStoryboard(name:  "Main", bundle: nil)
        
        guard let vc = storyboard.instantiateInitialController() as? ViewController else {
            return
        }
        
        guard let button = statusItem.button else {
            return
        }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
    }
}

