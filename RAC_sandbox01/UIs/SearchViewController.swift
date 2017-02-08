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
    
    fileprivate var searchViewModel: SearchViewModel? = SearchViewModel()
    fileprivate var searchTableDataSource: SearchTableDataSource? = SearchTableDataSource()

    // TODO:
    // 可能であればMutablePropertyに変える
//    private let (input, inputObserver) = Signal<String, NoError>.pipe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        shouldHideKeyboard()
    }
    
    // Action
    
    // TODO:
    // 可能であればdelegateをUIKit拡張(ReactiveCococa)に変える
    @IBAction func textDidChanged(_ sender: UITextField) {
        guard let keyword = sender.text else {
            return
        }
        clearButton.isHidden = keyword.characters.count == 0
        searchViewModel?.inputObserver.send(value: keyword)
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        textField.text = ""
        clearButton.isHidden = true
    }
    
    // private
    
    private func initView() {
        
        // set catch Datasource
        searchViewModel?.setCellModels?.signal.observeValues({ cellModels in
            self.searchTableDataSource?.set(with: cellModels)
            self.tableView.dataSource = self.searchTableDataSource
            self.reloadTableView()
        })
    }
    
    // for Alert
    
    private func showErrorAlert() {
        let alertController = AlertFactory.makeNetworkErrorAlert()
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // for debug
    
    private func reloadTableView() {
        tableView.reloadData()
        HUD.flash(.success, delay: 1.6)
    }
    
    // fileprivate
    
    fileprivate func shouldHideKeyboard() {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
    
    // TODO:
    // Coordintorでやる
//    fileprivate func tryDispWebView(cell: BookCell) {
//        let url: URL = cell.getLink()
//        let safariVC = SFSafariViewController(url: url)
//        self.present(safariVC, animated: true, completion: nil)
//    }
}

extension SearchViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookCell else {
            return
        }
        print(cell)
//        tryDispWebView(cell: cell)
    }
}

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        shouldHideKeyboard()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
