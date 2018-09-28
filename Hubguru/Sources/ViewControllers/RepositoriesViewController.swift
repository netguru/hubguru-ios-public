//
// RepositoriesViewController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

/// A view controller responsible for displaying repositories.
public final class RepositoriesViewController: UICollectionViewController {

	// MARK: Initializers

	/// Initialize an instance with a view model.
	///
	/// - Parameters:
	///     - viewModel: An instance of a view model.
	public init(viewModel: RepositoriesViewModel) {
		self.viewModel = viewModel
		super.init(collectionViewLayout: CollectionViewWalletLayout())
	}

	/// Initialize an instance with a default view model with its dependencies.
	///
	/// - Parameters:
	///     - apiRequester: An instance of API requester.
	public convenience init(apiRequester: ApiRequester) {
		self.init(viewModel: RepositoriesViewModel(apiRequester: apiRequester))
	}

	// MARK: Properties

	/// An instance of a view model.
	private let viewModel: RepositoriesViewModel

	/// A dispose bag.
	private let disposeBag = DisposeBag()

	// MARK: Setup

	/// Set up reactive bindings inside this view controller. This should be
	/// called once when setting up the view controller.
	private func setupReactiveBindings() {

		viewModel.repositories
			.bind(to: collectionView!.rx.items(cellIdentifier: viewModel.collectionViewCellReuseIdentifier, cellType: viewModel.collectionViewCellClass))(viewModel.collectionViewCellConfigure)
			.disposed(by: disposeBag)

	}

	// MARK: Overrides

	/// - SeeAlso: UIViewController.viewDidLoad()
	public override func viewDidLoad() {
		super.viewDidLoad()
		setupReactiveBindings()
	}

	// MARK: Unavailable

	/// - SeeAlso: NSCoding.init?(coder:)
	@available(*, unavailable) public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
