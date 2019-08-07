//
//  DrawView.swift
//  TouchTracker
//
//  Created by coastcao(操海兵) on 2019/8/3.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

//import Foundation
import UIKit

class DrawView: UIView{
    //var currentLine: Line?
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    
    @IBInspectable var finishedLineColor: UIColor =
        UIColor.black {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var currenctLineColor: UIColor =
        UIColor.red{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var lineThickness: CGFloat = 10{
        didSet{
            setNeedsDisplay()
        }
    }
    
    func stoke(_ line: Line) {
        let path = UIBezierPath()
        //path.lineWidth = 10
        path.lineWidth = lineThickness
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect: CGRect) {
        // draw finished lines in black
        //UIColor.black.setStroke()
        finishedLineColor.setStroke()
        
        for line in finishedLines{
            stoke(line)
        }
        
        /*
        if let line = currentLine {
            // If there is a line being drawn,
            // do it in red
            UIColor.red.setStroke()
            stoke(line)
        }*/
        
        //UIColor.red.setStroke()
        currenctLineColor.setStroke()
        for (_,line) in currentLines{
            stoke(line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        let touch = touches.first!
        let location = touch.location(in: self)
        
        currentLine = Line(begin: location, end: location)
        */
        
        print(#function)
        for touch in touches{
            let location = touch.location(in: self)
            let line = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = line
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        let touch = touches.first!
        currentLine?.end = touch.location(in: self)*/
        
        print(#function)
        for touch in touches{
            let location = touch.location(in: self)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = location
            
        }
        setNeedsDisplay()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        let touch = touches.first!
        let location = touch.location(in: self)
        currentLine?.end = location
        
        // onece the current line finishes, turn it black
        finishedLines.append(currentLine!)
        currentLine = nil */
        
        print(#function)
        for touch in touches{
            let location = touch.location(in: self)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = location
            finishedLines.append(currentLines[key]!)
            currentLines.removeValue(forKey: key)
            
        }
        setNeedsDisplay()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        setNeedsDisplay()
    }
    
    @objc func doubleTap(_ gestureRecognizer: UIGestureRecognizer){
        print("Double tap recognized!")
        currentLines.removeAll()
        finishedLines.removeAll()
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        //let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        let doubleTapRecognizer = UITapGestureRecognizer(target: self,
                                                         action: #selector(DrawView.doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
    }
}
