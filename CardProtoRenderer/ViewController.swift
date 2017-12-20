//
//  ViewController.swift
//  CardProtoRenderer
//
//  Created by Corey Perrigo on 12/19/17.
//  Copyright © 2017 Corey Perrigo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var dataPathField: NSTextField!
    @IBOutlet weak var outputPathField: NSTextField!
    @IBOutlet weak var dataPathBrowse: NSButton!
    @IBOutlet weak var outputPathBrowse: NSButton!
    @IBOutlet weak var runButton: NSButton!
    var openPanel: NSOpenPanel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openPanel = NSOpenPanel()
    }

    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func dataBrowsePressed(_ sender: Any) {
        openPanel.canChooseFiles = true
        openPanel.resolvesAliases = true
        openPanel.beginSheetModal(for: NSApplication.shared.mainWindow!) { (response:NSApplication.ModalResponse) in
            let path = self.openPanel.url?.path ?? ""
            self.dataPathField.stringValue = path
            if self.outputPathField.stringValue.count == 0 {
                self.outputPathField.stringValue = NSString(string: path + "/..").standardizingPath
            }
        }
    }
    
    @IBAction func outputBrowsePressed(_ sender: Any) {
        openPanel.canChooseDirectories = true
        openPanel.resolvesAliases = true
        openPanel.beginSheetModal(for: NSApplication.shared.mainWindow!) { (response:NSApplication.ModalResponse) in
            self.outputPathField.stringValue = self.openPanel.url?.path ?? ""
        }
    }
    
    @IBAction func runPressed(_ sender: Any) {
        
    }
}

