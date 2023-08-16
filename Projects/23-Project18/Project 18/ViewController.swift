//
//  ViewController.swift
//  Project 18
//
//  Created by Julio Braganca on 22/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: debuggint with prints
        //        print(1, 2, 3, 4, 5, separator: "-")
        
        //        print("some message", terminator: ".")
        
        // MARK: debugging with assert - they are never executed in a live app.
        //        assert(1 == 1, "Math failure!")
        //        assert(1 == 2, "Math failure!")
        //
        //        assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing.")
        
        // MARK: Debugging with breakpoints
        
        for i in 1...100 {
            print("Got number \(i).")
        }
        
        // MARK: View debugging
        
        // https://www.hackingwithswift.com/read/18/5/view-debugging
    }
    
    
}

