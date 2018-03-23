//
//  SecondViewController.swift
//  GestureTask
//
//  Created by Jon Boling on 3/22/18.
//  Copyright © 2018 Walt Boling. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
        
    @IBOutlet weak var goBackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapAnywhere = UITapGestureRecognizer(target: self, action: #selector(handleTapAnywhere(recognizer:)))
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(recognizer:)))
        swipeRight.direction = .right
        goBackLabel.text = ""
        
        view.gestureRecognizers = [tapAnywhere, swipeRight]
        
    }
    
    // Tap to Unveil Hidden Message
    @objc func handleTapAnywhere(recognizer: UITapGestureRecognizer) {
        goBackLabel.text = "There's Nothing To See Here! \nSwipe Right To Go Back!"
        
    }
    
    // Swipe to Return to First TabView
    @objc func handleSwipeRight(recognizer: UIGestureRecognizer) {
        goBackLabel.text = ""
        tabBarController?.selectedIndex = 0
    }



}

