//
// CollectionViewWalletLayoutAttributes.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

/// Custom attributes of a wallet layout.
public final class CollectionViewWalletLayoutAttributes: UICollectionViewLayoutAttributes {

	// MARK: Nested types

	/// Mode of layout attributes.
	public enum Mode {

		/// A mode when a cell is displayed among others in a vertical layout.
		case normal

		/// A mode when user selects one cell and it becomes the only
		/// highlighted cell.
		case featured

		/// A mode of other cells, stacked at the bottom when they are not
		/// featured.
		case discrete

	}

	// TODO: Add your implementation here.

}
