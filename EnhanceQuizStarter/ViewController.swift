
//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//
import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var newIndexNumber = 0
    var indexOfQuestion = 0
    
    // used a struct for the questions
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameSounds()
        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    
    func displayQuestion() {
        randomNumber()
        questionField.text = questionAndAnswer.question
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer uttons
        oneButton.isHidden = true
        twoButton.isHidden = true
        threeButton.isHidden = true
        fourButton.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let buttonPushed = sender
        rightOrWrongAnwserCheck(sender: buttonPushed)
        loadNextRound(delay: 3)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        oneButton.isHidden = false
        twoButton.isHidden = false
        threeButton.isHidden = false
        fourButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        arrayOfIndex = [Int]()
        nextRound()
    }
    
    
}
