//
//  ViewController.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/12.
//  Copyright © 2017年 msano. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import APIKit

class ViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        sendBooksRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // private
    
    private func initView() {
    }
    
    // Sending request
    
    private func sendBooksRequest() {
        let request = GetBooksRequest()
        Session.send(request) { result in
            switch result {
            case .success(let books):
//                print("booksData: \(books.list)")
                print("booksData: \(books.list[1].title)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    // Action
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let testViewController = TestViewController.instantiate()
        self.present(testViewController, animated: true, completion: nil)
    }

}
