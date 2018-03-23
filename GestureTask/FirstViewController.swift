//
//  FirstViewController.swift
//  GestureTask
//
//  Created by Jon Boling on 3/22/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit


// plan: swipe left/right = switch between tabs; swipe up/down = brightness bar?
// view 1: tap = count down from 10? longpress = reset; pinch = scale; rotate = rotate
// view2: tap = "there's nothing to see here. Swipe to return"

class FirstViewController: UIViewController {
    
    var maxCount = 10
    var countDown: Int!
    
    @IBOutlet weak var labelBox: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDown = maxCount
        countdownLabel.text = String(countDown)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(recognizer:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(recognizer:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        let swipeLGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeL(recognizer:)))
        swipeLGesture.direction = .left
        let screenEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleScreenEdgePan(recognizer:)))
        screenEdgePan.edges = .left
        
        labelBox.gestureRecognizers = [tapGesture, rotateGesture, pinchGesture, panGesture]
        backView.gestureRecognizers = [swipeLGesture, longPressGesture, screenEdgePan]
    }

    //Begin Countdown
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        if countDown > 0 {
            countDown = countDown - 1
            countdownLabel.text = String(countDown)
        }
    }
    
    //Rotate Countdown Label
    @objc func handleRotation(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    // Reset Countdown, Position, Size, Color
    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
        countDown = maxCount
        countdownLabel.text = String(countDown)
        if let view = recognizer.view {
            view.transform = CGAffineTransform.identity
            recognizer.view?.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0)
        }
    }
    
    // Pinch Zoom In/Out
    @objc func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1
        }
    }
    
    // Simple Pan function
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        let translationInView = recognizer.translation(in: self.view)
        recognizer.view!.center = CGPoint(x:view.center.x + translationInView.x, y:view.center.y + translationInView.y)
    }
    
    // Swipe to Second TabView
    @objc func handleSwipeL(recognizer: UISwipeGestureRecognizer) {
        tabBarController?.selectedIndex = 1
    }
    
    // For Psychodelic Indulgence (Long Press background to give your eyes a rest)
   @objc func handleScreenEdgePan(recognizer: UIScreenEdgePanGestureRecognizer) {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        recognizer.view?.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

