//
//  SearchViewController.swift
//  RAC_sandbox01
//
//  Created by msano on 2017/01/12.
//  Copyright © 2017年 msano. All rights reserved.
//

import SafariServices
import UIKit
import ReactiveSwift
import Result
import APIKit
import PKHUD

class SearchViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var searchViewModel: SearchViewModel?
    private var action: Action<String, String, NoError>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    // Action
    
    @IBAction func textDidChanged(_ sender: UITextField) {
        guard let keyword = sender.text else {
            return
        }
        clearButton.isHidden = keyword.characters.count == 0
        action?.apply(keyword)
            .start()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        textField.text = ""
        clearButton.isHidden = true
    }
    
    // private
    
    private func initView() {
        
        searchViewModel = SearchViewModel.init()
        
        // set input action
        action = Action<String, String, NoError> { (word) -> SignalProducer<String, NoError> in
            return SignalProducer<String, NoError> { (observer, disposable) in
                print("word: \(word)")
                observer.send(value: word)
                observer.sendCompleted()
            }
        }
        action?.values
            .debounce(1.0, on: QueueScheduler.main)
            .observeValues({ value in
                // TODO
                // RAC apiに置き換える
                if value.characters.count >= 1 {
                    HUD.flash(.progress, delay: 0.2)
                    self.searchViewModel?.sendBooksRequest(keyword: value)
                }
            })
        
        // set catch Datasource
        searchViewModel?.datasource?.signal.observeValues({ searchTableDataSource in
            self.tableView.dataSource = searchTableDataSource
            self.reloadTableView()
        })
    }
    
    // for Alert
    
    private func showErrorAlert() {
        let alertController = AlertFactory.makeNetworkErrorAlert()
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    // for debug
    
    private func moveTestVC() {
        let testViewController = TestViewController.instantiate()
        self.present(testViewController, animated: true, completion: nil)
    }
    
    func reloadTableView() {
        tableView.reloadData()
        HUD.flash(.success, delay: 1.6)
    }
}

extension SearchViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookCell else {
            return
        }
        tryDispWebView(cell: cell)
    }
}

extension SearchViewController: SFSafariViewControllerDelegate {
    func tryDispWebView(cell: BookCell) {
        let url: URL = cell.getLink()
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // スタブ
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
