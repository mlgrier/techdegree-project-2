//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Marco Grier on 1/4/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct Questions {
    var question: String
    var answer: String
}

var quiz = Questions(question: "", answer: "")
var correctQuestions = 0
var questionsAsked = 0
var arrayOfIndex = [Int]()


let questionsAndAnswers: [[String : String]] = [
    ["Question": "What is 0 + 1", "Answer": "1"],
    ["Question": "What is 1 + 1", "Answer": "2"],
    ["Question": "What is 1 + 2", "Answer": "3"],
    ["Question": "What is 1 + 3", "Answer": "4"],
    ["Question": "What is 9 - 8", "Answer": "1"],
    ["Question": "What is 12 - 10", "Answer": "2"],
    ["Question": "What is 13 - 10", "Answer": "3"],
    ["Question": "What is 14 - 10", "Answer": "4"],
    ["Question": "What is 7 - 6", "Answer": "1"],
    ["Question": "What is 22 - 20", "Answer": "2"],
    ["Question": "What is 33 - 30", "Answer": "3"],
    ["Question": "What is 100 - 96", "Answer": "4"],
    ["Question": "What is 29 - 28", "Answer": "1"],
    ["Question": "What is 8 - 6", "Answer": "2"],
    ["Question": "What is 17 - 14", "Answer": "3"],
    ["Question": "What is 48 - 44", "Answer": "4"]
]

func questionAndAnswerGenerator() -> Questions {
    
    var question: String
    let answer: String
    var indexOfSelectedQuestion: Int
    
    
    // Loop to check if index has been used
    repeat {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: questionsAndAnswers.count)
    } while arrayOfIndex.contains(indexOfSelectedQuestion)
    
    // Add index to array
    arrayOfIndex.append(indexOfSelectedQuestion)
    
    //NEED TO PULL THE QUESTION AND ANSWER FROM DICT THEN PASS TO STRUCT
    
    question = questionsAndAnswers[indexOfSelectedQuestion]["Question"] ?? "error"
    answer = questionsAndAnswers[indexOfSelectedQuestion]["Answer"] ?? "error"
    
    quiz = Questions(question: question, answer: answer)
    
    return quiz
    
}

extension ViewController {
    
    func rightOrWrongAnwserCheck(sender: UIButton) {
        
        // Increment the questions asked counter
        questionsAsked += 1
        
        let correctAnswer = quiz.answer
        
        if (sender === oneButton && correctAnswer == "1") || (sender === twoButton && correctAnswer == "2") || (sender === threeButton && correctAnswer == "3") || (sender === fourButton && correctAnswer == "4") {
            correctQuestions += 1
            playSoundFile(soundName: "CorrectAnswer", soundFileType: "mp3")
            questionField.text = "Correct!"
        } else {
            playSoundFile(soundName: "buzzersound", soundFileType: "mp3")
            questionField.text = "Sorry, wrong answer! \nThe correct answer is \(correctAnswer)."
        }
    }
}



