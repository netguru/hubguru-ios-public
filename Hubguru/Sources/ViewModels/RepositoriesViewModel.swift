//
// RepositoriesViewModel.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

/// A view model of `RepositoriesViewController`.
public final class RepositoriesViewModel {

	// MARK: Initializers

	/// Inititialize an instance with its dependencies.
	///
	/// - Parameters:
	///     - apiRequester: An instance of API requester.
	public init(apiRequester: ApiRequester) {
		self.apiRequester = apiRequester
	}

	// MARK: Properties - private

	/// An instance of API requester.
	private let apiRequester: ApiRequester

	/// An instance of pageable provider.
	private var provider: PageableProvider {
		return PageableProvider(apiRequester: apiRequester)
	}

	// MARK: Properties - data

	/// An observable of repositories.
	public var repositories: Observable<[Repository]> {
		// TODO: Add your implemenattion here.
		return Observable.just([])
	}

	// MARK: Properties - collection view

	/// A collection view cell class.
	public let collectionViewCellClass: UICollectionViewCell.Type = RepositoryCollectionViewCell.self

	/// A collection view cell reuse identifier.
	public var collectionViewCellReuseIdentifier: String {
		return String(describing: collectionViewCellClass)
	}

	/// A closure that configures a collection view cell. To be used with Rx
	/// data source bindings.
	public var collectionViewCellConfigure: (Int, Repository, UICollectionViewCell) -> Void {
		return { _, repository, cell in
			if let cell = cell as? RepositoryCollectionViewCell {
				cell.nameLabel.text = repository.name
				// TODO: Add your implemenattion here.
			}
		}
	}

}
