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
    @IBOutlet weak var tableView: UITableView!
    
    var booklist: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // private
    
    private func initView() {
//        initTableView()
        sendBooksRequest()
    }
    
    // Sending request
    
    private func sendBooksRequest() {
        let request = GetBooksRequest()
        Session.send(request) { result in
            switch result {
            case .success(let books):
//                print("booksData: \(books.list)")
                print("booksData: \(books.list[1].title)")
                self.booklist = books.list
                self.reloadTableView()
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

extension ViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookCell else {
            return
        }
        print("\(cell.getLink())")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booklist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.makeCell(tableView: tableView, cellForRowAtIndexPath: indexPath)
    }

    func initTableView() {
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "BookCell")
        //        self.tableView?.registerNib(UINib(nibName: CELL_IDENTIFIER_DESC, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIER_DESC)
    }
    
    // セル生成
    private func makeCell(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> BookCell {
        if booklist.count < indexPath.row {
            return UITableViewCell() as! BookCell
        }
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
            return UITableViewCell() as! BookCell
        }
        guard let book: Book = booklist[indexPath.row] else {
            return UITableViewCell() as! BookCell
        }
        
        cell.selectionStyle  = UITableViewCellSelectionStyle.none
        cell.glueData(book: book)
        return cell
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // スタブ
    }
}
