//
//  InterfaceController.swift
//  SequencePlay WatchKit Extension
//
//  Created by Romil Parhwal on 2019-03-14.
//  Copyright © 2019 Romil Parhwal. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var labelWelcome: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        if(sharedInstance.getName()==""){
            let suggestedResponses = ["Bill", "Jenelle", "Emad", "Romil"]
            presentTextInputController(withSuggestions: suggestedResponses, allowedInputMode: .plain) { (results) in
                
                
                if (results != nil && results!.count > 0) {
                    // 2. write your code to process the person's response
                    let userResponse = results?.first as? String
                    sharedInstance.setName(userResponse!)
                    self.labelWelcome.setText("Welcome "+sharedInstance.getName())
                }
            }
        } else{
            self.labelWelcome.setText("Welcome "+sharedInstance.getName())
        }
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func setHardMode() { sharedInstance.setGameType(false)
        print(sharedInstance.returnGameType())
        presentController(withName: "gameController", context: "segue")
        
        }
    @IBAction func setEasyMode() {
        print("EASY")
        sharedInstance.setGameType(true)
        print(sharedInstance.returnGameType())
        presentController(withName: "gameController", context: "segue")
    }
}
