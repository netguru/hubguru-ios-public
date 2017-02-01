//
// RepositoryCollectionViewCellController.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

/// A controller of `RepositoryCollectionViewCell`.
public final class RepositoryCollectionViewCellController {

	// MARK: Initializers

	/// Initialize an instance with an owning cell.
	///
	/// - Properties:
	///    - cell: An owning cell.
	public init(cell: RepositoryCollectionViewCell) {
		self.cell = cell
	}

	// MARK: Properties

	/// An owning cell.
	private weak var cell: RepositoryCollectionViewCell?

	// MARK: Lifecycle

	/// Called by cell when it is applying layout attributes.
	///
	/// - Parameters:
	///     - layoutAttributes: Latyout attributes that cell is applying.
	public func cellIsApplyingLayoutAttributes(_ layoutAttributes: UICollectionViewLayoutAttributes) {
		// TODO: Add your implemenattion here.
	}

	/// Called by cell when it is preparing for reuse.
	public func cellIsPreparingForReuse() {
		// TODO: Add your implemenattion here.
	}

}
