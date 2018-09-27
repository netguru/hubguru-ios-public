//
//  SortingViewController.swift
//  Hubguru
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum SortType: String {
    case stars, forks, updated
    static let allValues: [SortType] = [.stars, .forks, .updated]
}

protocol SortingViewControllerDelegate {
    func sortingController(sortingViewController: SortingViewController, didSelectSortType: SortType)
}

class SortingViewController: UITableViewController {
    
    fileprivate let allTypes = Observable.just(SortType.allValues)
    fileprivate let reuseIdentifier = "cellReuseIdentifier"
    fileprivate let disposeBag = DisposeBag()
    var delegate: SortingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        title = NSLocalizedString("SortingViewController.title", comment: "Select sort type")
        
        allTypes.bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: UITableViewCell.self)) { row, type, cell in
            cell.textLabel?.text = type.rawValue
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SortType.self).subscribe(onNext: { [weak self] type in
            guard let strongSelf = self, let selectedRowIndexPath = strongSelf.tableView.indexPathForSelectedRow, let delegate = strongSelf.delegate else {
                return
            }
            strongSelf.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
            delegate.sortingController(sortingViewController: strongSelf, didSelectSortType: type)
        }).disposed(by: disposeBag)
        
    }
}
