//
//  FeedbackVC.swift
//  Learn
//
//  Created by Shoaib uddin on 12/10/2019.
//  Copyright © 2019 pixel. All rights reserved.
//

import Foundation
import UIKit


class FeedbackVC: BaseVC{
    
    
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        showNavigationBar();
        textView.becomeFirstResponder();
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showNavigationBar();
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        hideNavigationBar();
    }
    
    @IBAction func closeView(sender: Any){
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func submitView(sender: Any){
        
        let feedback = textView.text;
        if(feedback == nil || feedback == ""){
            return;
        }
        
        print(feedback);
        
        if let fb = feedback {
            LearnottoApi.addFeedback(feedback: fb) { (success) in
                
            }
        }
        
        
        
        self.dismiss(animated: true) {
            UtilityHelper.AlertMessage("Thank You")
        }
        
        
        
        
        
        
    }
    
}
