//
//  CardViewController.swift
//  CardProtoRenderer
//
//  Created by Corey Perrigo on 12/22/17.
//  Copyright © 2017 Corey Perrigo. All rights reserved.
//

import Cocoa

class CardFrontViewController: NSViewController {
    
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var flavorTextLabel: NSTextField!
    @IBOutlet weak var questProgressIndicator: NSLevelIndicator!
    @IBOutlet weak var questTitleLabel: NSTextField!
    
    var card: Card? {
        didSet {
            guard let reqCard = card else {
                titleLabel.stringValue = ""
                titleLabel.stringValue = ""
                questProgressIndicator.isHidden = true
                questTitleLabel.isHidden = true
                return
            }
            titleLabel.stringValue = reqCard.name
            flavorTextLabel.stringValue = reqCard.flavorText
            if let quest = card?.quest {
                questProgressIndicator.isHidden = false
                questTitleLabel.isHidden = false
                questProgressIndicator.minValue = 0
                questProgressIndicator.maxValue = Double(quest.maxProgress)
                questProgressIndicator.intValue = Int32(quest.progress)
                questTitleLabel.stringValue = quest.name
            } else {
                questProgressIndicator.isHidden = true
                questTitleLabel.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
