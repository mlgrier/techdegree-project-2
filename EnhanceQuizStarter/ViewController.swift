//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox


class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var newIndexNumber = 0
    var indexOfQuestion = 0
    
    var arrayOfIndex = [Int]()
    
    var gameSound: SystemSoundID = 0
    var buzzerSound: SystemSoundID = 0
    var currectSound: SystemSoundID = 0
    
    // used a struct for the questions
    
    var question = Questions(question: "", answer: "")
    
    //var question = Questions(question: questionsAndAnswers[0]["Question"] ?? "error", answer: questionsAndAnswers[0]["Answer"] ?? "error")
    
    //var question = Questions(question: questionsProvider, answer: questionsProvider)

    
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
    
    func loadGameSounds() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        
        let path2 = Bundle.main.path(forResource: "CorrectAnswer", ofType: "mp3")
        let soundUrl2 = URL(fileURLWithPath: path2!)
        AudioServicesCreateSystemSoundID(soundUrl2 as CFURL, &currectSound)
        
        let path3 = Bundle.main.path(forResource: "buzzersound", ofType: "mp3")
        let soundUrl3 = URL(fileURLWithPath: path3!)
        AudioServicesCreateSystemSoundID(soundUrl3 as CFURL, &buzzerSound)
    }
    
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func currectAnswerSound() {
        AudioServicesPlaySystemSound(currectSound)
    }
    
    func wrongAnswerSound() {
       AudioServicesPlaySystemSound(buzzerSound)
    }
    
    func randomNumber() -> Int {
        // Loop to check if index has been used
        repeat {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionsAndAnswers.count)
        } while arrayOfIndex.contains(indexOfSelectedQuestion)
        // Add index to array
        arrayOfIndex.append(indexOfSelectedQuestion)
        
        question = Questions(question: questionsAndAnswers[indexOfSelectedQuestion]["Question"] ?? "error", answer: questionsAndAnswers[indexOfSelectedQuestion]["Answer"] ?? "error")
        
        return indexOfSelectedQuestion
    }
    
    func displayQuestion() {
        indexOfQuestion = randomNumber()
        
        let questionDictionary = question.question
        print(questionDictionary)
        
        //triviaProvider.trivia[indexOfQuestion]
        questionField.text = questionDictionary
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
        // Increment the questions asked counter
        questionsAsked += 1
        
        let selectedQuestionDict = question.answer
        
        //triviaProvider.trivia[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict
        
        //selectedQuestionDict["Answer"]
        
        if (sender === oneButton &&  correctAnswer == "1") || (sender === twoButton && correctAnswer == "2") || (sender === threeButton &&  correctAnswer == "3") || (sender === fourButton &&  correctAnswer == "4") {
            correctQuestions += 1
            currectAnswerSound()
            questionField.text = "Correct!"
        } else {
            wrongAnswerSound()
            questionField.text = "Sorry, wrong answer! \nThe correct answer is \(correctAnswer)."
        }
        
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

