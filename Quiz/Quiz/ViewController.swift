//
//  ViewController.swift
//  Quiz
//
//  Created by 操海兵 on 2019/6/9.
//  Copyright © 2019 Coast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet var questionLabel : UILabel!
    @IBOutlet var currentQuestionLabel : UILabel!
    @IBOutlet var nextQuestionLabel : UILabel!
    @IBOutlet var answerLabel : UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
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
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
        //answerLabel.text = "..."
        // Do any additional setup after loading the view, typically from a nib.
    }

    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        print("\(screenWidth)")
        self.nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateLabelTransitions() {
        //let animationClosure = { () -> Void in
        //    self.questionLabel.alpha = 1
        //}
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 1.0,
                       delay:0,
                       options: [.curveLinear],
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                        self.updateOffScreenLabel()
                        
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nextQuestionLabel.alpha = 0
    }

}

