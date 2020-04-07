//
//  AppDelegate.swift
//  TranslateIt
//
//  Created by André Grecco Carvalho on 02/04/20.
//  Copyright © 2020 André Grecco Carvalho. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var principalItem = NSStatusItem()
    var popup = NSPopover()
    
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        principalItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        principalItem.button?.image = NSImage(named: "StatusBarMenuImage")
        principalItem.button?.action = #selector(AppDelegate.togglePopup(_:))
        popup.contentViewController=NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "ViewController") as! ViewController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func showPopup(_ sender: AnyObject?) {
        if let button = principalItem.button {
            popup.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            popup.behavior = .transient
        }
    }
    
    func closePopup(_ sender: AnyObject?) {
        popup.performClose(sender);
    }
    
    
    @objc func togglePopup(_ sender: AnyObject) {
        if popup.isShown {
            closePopup(sender)
        } else {
            showPopup(sender)
        }
    }

}

