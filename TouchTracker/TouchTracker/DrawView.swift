//
//  DrawView.swift
//  TouchTracker
//
//  Created by coastcao(操海兵) on 2019/8/3.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

//import Foundation
import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate{
    //var currentLine: Line?
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    var selectedLineIndex : Int? {
        didSet {
            if selectedLineIndex == nil {
                let menu = UIMenuController.shared
                menu.setMenuVisible(false, animated: true)
            }
        }
    }
    var moveRecognizer: UIPanGestureRecognizer!
    
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
        
        if let index = selectedLineIndex {
            UIColor.green.setStroke()
            let selectedLine = finishedLines[index]
            stoke(selectedLine)
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
        print("A double tap is recognized!")
        currentLines.removeAll()
        finishedLines.removeAll()
        selectedLineIndex = nil
        setNeedsDisplay()
    }
    
    func getSelectedLineIndex(_ point:CGPoint) -> Int? {
        for(index, line) in finishedLines.enumerated(){
            let begin = line.begin
            let end = line.end
            
            for t in stride(from: CGFloat(0), to: 1.0, by: 0.05) {
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
                
                if hypot(x-point.x, y-point.y) < 20.0{
                    return index
                }
            }
        }
        return nil
    }
    
    // ??? why the parameter is UIMenuController object?
    @objc func deleteLine(_ sender: UIMenuController) {
        if let index = selectedLineIndex {
            finishedLines.remove(at: index)
            selectedLineIndex = nil
            
            setNeedsDisplay()
        }
    }
    
    // ??? why the parameter is UIGestureRecognizer object?
    @objc func tap(_ gestureRecognizer: UIGestureRecognizer) {
        print("A tap is recognized!")
        let location = gestureRecognizer.location(in: self)
        selectedLineIndex = getSelectedLineIndex(location)
        //print(selectedLineIndex!)
        
        let menu = UIMenuController.shared
        
        if selectedLineIndex != nil {
            becomeFirstResponder()
            
            let deleteItem = UIMenuItem(title: "Delete",
                                        action: #selector(DrawView.deleteLine(_:)))
            menu.menuItems = [deleteItem]
            
            let targetRect = CGRect(x: location.x, y: location.y, width:2, height: 2)
            menu.setTargetRect(targetRect, in: self)
            menu.setMenuVisible(true, animated: true)
            print("to delete")
        } else {
            menu.setMenuVisible(false, animated: true)
        }
        setNeedsDisplay()
    }
    
    @objc func longPress(_ gestureRecognizer: UIGestureRecognizer) {
        print("A long press is recognized!")
        
        if (gestureRecognizer.state == .began) {
            let location = gestureRecognizer.location(in: self)
            selectedLineIndex = getSelectedLineIndex(location)
            
            if (selectedLineIndex != nil) {
                currentLines.removeAll()
            }
        } else if (gestureRecognizer.state == .ended) {
            selectedLineIndex = nil
        }
        
        setNeedsDisplay()
    }
    
    @objc func moveLine(_ gestureRecognizer: UIPanGestureRecognizer) {
        print("A pan is recognized!")
        
        if let index = selectedLineIndex {
            if gestureRecognizer.state == .changed {
                let translation = gestureRecognizer.translation(in: self)
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
            } else {
                return
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        //let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        let doubleTapRecognizer = UITapGestureRecognizer(target: self,
                                                         action: #selector(DrawView.doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(DrawView.tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                               action: #selector(DrawView.longPress))
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self,
                                                action: #selector(DrawView.moveLine))
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
        
    }
}
