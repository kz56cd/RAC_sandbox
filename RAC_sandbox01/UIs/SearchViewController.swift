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

class SearchViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var bookCellModels: BookCellModels?
    fileprivate var datasource: SearchTableDataSource?
    
    
    private var action: Action<String, String, NoError>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Action
    
//    @IBAction func buttonTapped(_ sender: UIButton) {
//        // moveTestVC()
//        guard let keyword = textField.text else {
//            return
//        }
//        sendBooksRequest(keyword: keyword)
//    }
    
    @IBAction func textDidChanged(_ sender: UITextField) {
        guard let keyword = sender.text else {
            return
        }
//        guard let signalProducer: SignalProducer<String, NoError> = action?.apply(keyword) as SignalProducer<String, NoError> else {
//            print("駄目です")
//            return
//        }
        action?.apply(keyword).startWithResult { result in
            switch result {
            case let .success(value):
                print("value: \(value)")
            case let .failure(error):
                print("error: \(error)")
            }
        }
        
    }
    
    // private
    
    private func initView() {
        
        action = Action<String, String, NoError> { (word) -> SignalProducer<String, NoError> in
            return SignalProducer<String, NoError> { (observer, disposable) in
                observer.send(value: word)
                observer.sendCompleted()
            }
        }
        
        action?.values.observeValues({ value in
            print("value: \(value)")
            print("来てます")
            
            // TODO
            // RAC apiに置き換える
            if value.characters.count >= 1 {
                self.sendBooksRequest(keyword: value)
            }
        })
    }
    
    // Sending request
    
    private func sendBooksRequest(keyword: String) {
        let request = GetBooksRequest(keyword: keyword)
        Session.send(request) { result in
            switch result {
            case .success(let books):
                self.configureResult(books: books)
            case .failure(let error):
                print("error: \(error)")
                self.showErrorAlert()
            }
        }
    }
    
    private func configureResult(books: Books) {
        self.bookCellModels = BookCellModels.init(model: books.list)
        self.datasource = SearchTableDataSource(cellModels: self.bookCellModels!)
        self.tableView.dataSource = self.datasource
        self.reloadTableView()
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
    
    private func reloadTableView() {
        tableView.reloadData()
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
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        return true
    }
}
