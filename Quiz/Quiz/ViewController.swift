//
//  ViewController.swift
//  Quiz
//
//  Created by 操海兵 on 2019/6/9.
//  Copyright © 2019 Coast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var questionLabel : UILabel!
    @IBOutlet var answerLabel : UILabel!
    
    let questions : [String] = [
        "What is 7+7?",
        "What is the capital of China?",
        "What is weather today?"
    ]
    let answers : [String] = [
        "14",
        "Beijing",
        "Cloudy"
    ]
    var currentQuestionIndex : Int = 0
    
    @IBAction func showNextQuestion(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        let question = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

