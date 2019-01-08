//
//  GameManager.swift
//  EnhanceQuizStarter
//
//  Created by Marco Grier on 1/4/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import GameKit

var quiz = Question(question: "", answer: "")
var correctQuestions = 0
var questionsAsked = 0
var arrayOfIndex = [Int]()

struct Question {
    var question: String
    var answer: String
}

let quizQuestions = [
    Question(question: "What is 0 + 1", answer: "1"),
    Question(question: "What is 1 + 1", answer: "2"),
    Question(question: "What is 1 + 2", answer: "3"),
    Question(question: "What is 1 + 3", answer: "4"),
    Question(question: "What is 9 - 8", answer: "1"),
    Question(question: "What is 12 - 10", answer: "2"),
    Question(question: "What is 13 - 10", answer: "3"),
    Question(question: "What is 14 - 10", answer: "4"),
    Question(question: "What is 7 - 6", answer: "1"),
    Question(question: "What is 22 - 20", answer: "2"),
    Question(question: "What is 33 - 30", answer: "3"),
    Question(question: "What is 100 - 96", answer: "4"),
    Question(question: "What is 29 - 28", answer: "1"),
    Question(question: "What is 8 - 6", answer: "2"),
    Question(question: "What is 17 - 14", answer: "3"),
    Question(question: "What is 48 - 44", answer: "4")
]

func questionAndAnswerGenerator() -> Question {
    
    let question: String
    let answer: String
    var indexOfSelectedQuestion: Int
    
    
    // Loop to check if index has been used
    repeat {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quizQuestions.count)
    } while arrayOfIndex.contains(indexOfSelectedQuestion)
    
    // Add index to array
    arrayOfIndex.append(indexOfSelectedQuestion)
    
    //NEED TO PULL THE QUESTION AND ANSWER FROM ARRAY THEN PASS TO STRUCT
    
    question = quizQuestions[indexOfSelectedQuestion].question
    answer = quizQuestions[indexOfSelectedQuestion].answer
    
    quiz = Question(question: question, answer: answer)
    
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



