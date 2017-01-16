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

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // private
    
    private func initView() {
        let printIt: (String) -> () = {
            next in print("next: \(next)")
        }
        
        testSignal().observeValues(printIt)
        
    }
    
    private func testSignal() -> Signal<String, NoError> {
        return Signal { observer in
            DispatchQueue.main.async {
                var i = 0
                while i < 10 {
                    observer.send(value: String(i))
                    i += 1
                }
            }
            // observer.sendCompleted() // イベントストリーム終了
            return nil
        }
    }
}
