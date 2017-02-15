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

final class SearchViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    weak var searchCoordinator: SearchCoordinator? // TODO: VM経由にすれば、直接VCとCoordinatorがやりとりする必要はなくなる
    fileprivate var searchViewModel: SearchViewModelProtocol = SearchViewModel() // TODO: DI的に、外から入れる
    fileprivate var searchTableDataSource = SearchTableDataSource() // TODO: DI的に、外から入れる方がいいかも
    
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
        clearButton.isHidden = keyword.characters.count == 0 // TODO: clearButtonの制御がVCに入ってしまっているので、VM側に移したい
        searchViewModel.input.value = keyword
        HUD.flash(.progress, delay: 0.3) // TODO: この表示にdebounceが効いていない。設計的には、VM側から制御したい
    }

    @IBAction func clearButtonTapped(_ sender: UIButton) {
        textField.text = "" // TODO: これもVM側からの命令でやるようにしたい
        clearButton.isHidden = true // TODO: clearButtonの制御がVCに入ってしまっているので、VM側に移したい
    }

    // private

    private func initView() {
        tableView.dataSource = searchTableDataSource
        tableView.delegate = self
        
        _ = searchViewModel.cellModels.signal
            .observe(on: UIScheduler())
            .observeValues { [weak self] cellModels in
                self?.searchTableDataSource.updateCellModels(to: cellModels)
                self?.reloadTableView()
        }
    }

    // for Alert

    private func showErrorAlert() {
        let alertController = AlertFactory.makeNetworkErrorAlert()
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    private func reloadTableView() {
        tableView.reloadData()
        if searchViewModel.cellModels.value.count > 0 {
            HUD.flash(.success, delay: 1.6) // TODO: これもVM側からの命令でやるようにしたい
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
        guard let book = searchViewModel.book(at: indexPath.row) else {
            return
        }
        searchCoordinator?.presentBookDetail(with: book) // TODO: VCとCoordinatorが直接やり取りするより、VMを経由してやりとりしたほうがよいかも
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
