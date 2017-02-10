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

    var searchCoordinator: SearchCoordinator?
    fileprivate var searchViewModel: SearchViewModel? = SearchViewModel()
    fileprivate var searchTableDataSource: SearchTableDataSource? = SearchTableDataSource()

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
        searchViewModel?.input.value = keyword
        HUD.flash(.progress, delay: 0.3)
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        textField.text = ""
        clearButton.isHidden = true
    }

    // private

    private func initView() {

        // set catch Datasource
        _ = searchViewModel?.setCellModels?.signal.observeValues({ cellModels in
            self.searchViewModel?.bookCellModels = cellModels
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

    private func reloadTableView() {
        tableView.reloadData()
        if (searchViewModel?.bookCellModels.count)! > 0 {
            HUD.flash(.success, delay: 1.6)
        }
    }

    // fileprivate

    fileprivate func shouldHideKeyboard() {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = searchViewModel?.getBook(with: indexPath.row) else {
            return
        }
        searchCoordinator?.presentBookDetail(with: book)
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
