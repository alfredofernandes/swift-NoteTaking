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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textView.text = "New Note"
    }
    
    func setText(t: String) {
        text = t
        if isViewLoaded {
            textView.text = t
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
