//
//  ViewController.swift
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


class ViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var booklist: [Book] = []
    var booksCellModels: BookCellModels?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Action
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // moveTestVC()
        guard let keyword = textField.text else {
            return
        }
        sendBooksRequest(keyword: keyword)
    }
    
    // private
    
    private func initView() {
//        sendBooksRequest(keyword: "java")
    }
    
    // Sending request
    
    private func sendBooksRequest(keyword: String) {
        let request = GetBooksRequest(keyword: keyword)
        Session.send(request) { result in
            switch result {
            case .success(let books):
                self.booksCellModels = BookCellModels.init(model: books.list)
                self.reloadTableView()
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    // for debug
    
    private func moveTestVC() {
        let testViewController = TestViewController.instantiate()
        self.present(testViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookCell else {
            return
        }
        tryDispWebView(cell: cell)
    }
}

extension ViewController: SFSafariViewControllerDelegate {
    func tryDispWebView(cell: BookCell) {
        guard let url: URL = cell.getLink() else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksCellModels?.cells?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.makeCell(tableView: tableView, cellForRowAtIndexPath: indexPath)
    }

    func initTableView() {
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
    }
    
    // セル生成
    private func makeCell(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> BookCell {
        guard let cells = booksCellModels?.cells else {
            return UITableViewCell() as! BookCell
        }
        if (booksCellModels?.cells?.count ?? 0) < indexPath.row {
            return UITableViewCell() as! BookCell
        }
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
            return UITableViewCell() as! BookCell
        }
        guard let bookCellModel: BookCellModel = cells[indexPath.row] else {
            return UITableViewCell() as! BookCell
        }
        cell.selectionStyle  = UITableViewCellSelectionStyle.none
        cell.configure(cellModel: bookCellModel)
        return cell
    }
    
    fileprivate func reloadTableView() {
        tableView.reloadData()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // スタブ
    }
}
