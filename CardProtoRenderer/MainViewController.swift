//
//  ViewController.swift
//  CardProtoRenderer
//
//  Created by Corey Perrigo on 12/19/17.
//  Copyright © 2017 Corey Perrigo. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var dataPathField: NSTextField!
    @IBOutlet weak var outputPathField: NSTextField!
    @IBOutlet weak var dataPathBrowse: NSButton!
    @IBOutlet weak var outputPathBrowse: NSButton!
    @IBOutlet weak var runButton: NSButton!
    @IBOutlet var outputView: NSTextView!
    @IBOutlet weak var cardPreview: NSView!
    
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
        outputView.textStorage?.setAttributedString(NSAttributedString(string: ""))
        let cards = parseData(path: dataPathField.stringValue)
        for card in cards {
            var text = String(format: "%@ -- %@\n", card.name, card.flavorText)
            for option in card.options {
                text.append(String(format: "\t%@: %@\n", option.text, option.effect ?? ""))
            }
            outputView.textStorage?.append(NSAttributedString(string: text));
//            print(String(format: "%@ -- %@", card.name, card.flavorText))
        }
        let card = cards[0]
        let cardController = CardFrontViewController()
        cardController.card = card
        cardPreview.subviews = [cardController.view]
    }
    
    func readFile(path: String) -> String? {
        do {
            let url = URL(fileURLWithPath: path)
            let s = try String(contentsOf: url)
            return s
        } catch {
            print("error processing: \(path): \(error)")
        }
        return nil
    }
    
    func parseData(path: String) -> [Card] {
        let decoder = JSONDecoder()
        do {
            guard let fileString = readFile(path: path) else {
                return [Card]()
            }
            let fileData = fileString.data(using: .utf8)!
            return try decoder.decode([Card].self, from: fileData)
        } catch {
            print("Error converting data to JSON")
            print(error)
        }
        return [Card]()
    }
}

