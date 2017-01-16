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

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        sendRequest()
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
    
    // Sending request
    
    private func sendRequest() {
        let request = GetWeatherRequest()
        Session.send(request) { result in
            switch result {
            case .success(let weatherData):
                print("title: \(weatherData.title)")
                print("description: \(weatherData.descripton)")
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

}
