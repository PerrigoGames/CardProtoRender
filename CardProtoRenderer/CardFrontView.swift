//
//  CardFrontView.swift
//  CardProtoRenderer
//
//  Created by Corey Perrigo on 12/27/17.
//  Copyright © 2017 Corey Perrigo. All rights reserved.
//

import Cocoa

class CardFrontView: NSViewController {

    @IBOutlet weak var cardTitle: NSTextField!
    @IBOutlet weak var flavorText: NSTextField!
    @IBOutlet weak var questProgress: NSLevelIndicator!
    @IBOutlet weak var questTitle: NSTextField!
    
    var card: Card? {
        didSet {
            if(isViewLoaded) {
                refreshCardDetails()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshCardDetails()
    }
    
    func refreshCardDetails() {
        guard let reqCard = card else {
            cardTitle.stringValue = ""
            flavorText.stringValue = ""
            questProgress.isHidden = true
            questTitle.isHidden = true
            return
        }
        cardTitle.stringValue = reqCard.name
        cardTitle.sizeToFit()
        flavorText.stringValue = reqCard.flavorText
        if let quest = card?.quest {
            questProgress.isHidden = false
            questTitle.isHidden = false
            questProgress.minValue = 0
            questProgress.maxValue = Double(quest.maxProgress)
            questProgress.intValue = Int32(quest.progress)
            questTitle.stringValue = quest.name
        } else {
            questProgress.isHidden = true
            questTitle.isHidden = true
        }
    }
    
//    override func controlTextDidChange(_ obj: Notification) {
//        flaot height = cardTitle.cell?.cellSize(forBounds: cardTitle.bounds).height
//        cardTitle.
//    }
}
