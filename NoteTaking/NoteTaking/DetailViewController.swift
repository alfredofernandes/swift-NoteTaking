//
//  DetailViewController.swift
//  NoteTaking
//
//  Created by Alfredo Fernandes on 2017-11-22.
//  Copyright © 2017 Alfredo Fernandes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var text: String = ""
    var refToMasterView: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = text
        textView.becomeFirstResponder()
    }
    
    func setText(t: String) {
        text = t
        
        if isViewLoaded {
            textView.text = t
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        refToMasterView.newRowText = textView.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

