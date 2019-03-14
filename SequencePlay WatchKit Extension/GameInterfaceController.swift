//
//  GameInterfaceController.swift
//  SequencePlay WatchKit Extension
//
//  Created by Romil Parhwal on 2019-03-14.
//  Copyright © 2019 Romil Parhwal. All rights reserved.
//

import WatchKit

class GameInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var buttonOne: WKInterfaceButton!
    
    @IBOutlet weak var buttonTwo: WKInterfaceButton!
    
    
    @IBOutlet weak var buttonThree: WKInterfaceButton!
    
    
    @IBOutlet weak var buttonFour: WKInterfaceButton!
    
    var randomNumber:Int = 0
    
    var isWatching = true {
        didSet {
            if isWatching {
                setTitle("WATCH!")
            } else {
                setTitle("REPEAT!")
            }
        }
    }
    
    var sequence = [WKInterfaceButton]()
    var sequenceIndex = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        print(sharedInstance.returnGameType())
        startNewGame()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func playNextSequenceItem() {
        // stop flashing if we've finished our sequence
        guard sequenceIndex < sequence.count else {
            isWatching = false
            sequenceIndex = 0
            return
        }
        
        // otherwise move our sequence forward
        let button = sequence[sequenceIndex]
        sequenceIndex += 1
        
        // wait a fraction of a second before flashing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            // mark this button as being active
            button.setTitle("•")
            
            // wait again
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // deactivate the button and flash again
                button.setTitle("")
                self?.playNextSequenceItem()
            }
        }
    }
    
    func addToSequence() {
        if(sharedInstance.returnGameType()==true){
            sequence.removeAll()
        }
        let buttons: [WKInterfaceButton] = [buttonOne, buttonTwo, buttonThree, buttonFour]
        
        for _ in 1...4 {
            sequence.append(buttons.randomElement()!)
        }
        
        sequenceIndex = 0
        isWatching = true
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
            self.playNextSequenceItem()
        }
    }
    
    func startNewGame() {
        sequence.removeAll()
        addToSequence()
    }
    
    func makeMove(_ buttons: WKInterfaceButton) {
        // don't let the player touch stuff while in watch mode
        guard isWatching == false else { return }
        
        if sequence[sequenceIndex] == buttons {
            // they were correct! Increment the sequence index.
            sequenceIndex += 1
            
            if sequenceIndex == sequence.count {
                // they made it to the end; add another button to the sequence
                addToSequence()
            }
        } else {
            // they were wrong! End the game.
            let playAgain = WKAlertAction(title: "Play Again", style: .default) {
                self.startNewGame()
            }
            
            presentAlert(withTitle: "Game over!", message: "Play Again", preferredStyle: .alert, actions: [playAgain])
        }
    }
    
    
    @IBAction func buttonOnePressed() {
        makeMove(buttonOne)
    }
    
    @IBAction func buttonTwoPressed() {
        makeMove(buttonTwo)
    }
    
    @IBAction func buttonThreePressed() {
        makeMove(buttonThree)
    }
    
    @IBAction func buttonFourPressed() {
        makeMove(buttonFour)
    }
}
