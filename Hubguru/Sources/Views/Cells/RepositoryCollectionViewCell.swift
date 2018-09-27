//
// RepositoryCollectionViewCell.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import EasyPeasy
import UIKit

/// A collection view cell of `RepositoriesViewController`.
public final class RepositoryCollectionViewCell: UICollectionViewCell {

	// MARK: Initializers

	/// - SeeAlso: UIView.init(frame:)
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewHierarchy()
	}

	// MARK: Properties

	/// A controller of this cell.
	private lazy var controller: RepositoryCollectionViewCellController = RepositoryCollectionViewCellController(cell: self)

	// MARK: Properties - subviews

	public private(set) lazy var ownerLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18, weight: .light)
		label.textColor = .black
		return label
	}()

	private lazy var slashLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18, weight: .light)
		label.textColor = .black
		label.text = "/"
		return label
	}()

	public private(set) lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18, weight: .medium)
		label.textColor = .black
		return label
	}()

	// MARK: Setup

	/// Set up view hierarchy inside this cell.
	private func setupViewHierarchy() {

		contentView.addSubview(ownerLabel)
		contentView.addSubview(slashLabel)
		contentView.addSubview(nameLabel)

		ownerLabel.easy.layout([Top(16), Left(16)])
		slashLabel.easy.layout([FirstBaseline().to(ownerLabel), Left(4).to(ownerLabel)])
		nameLabel.easy.layout([FirstBaseline().to(slashLabel), Left(4).to(slashLabel), Right(16)])

	}

	// MARK: Overrides

	/// - SeeAlso: UICollectionReusableView.apply(_:)
	public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
		super.apply(layoutAttributes)
		controller.cellIsApplyingLayoutAttributes(layoutAttributes)
	}

	/// - SeeAlso: UICollectionReusableView.prepareForReuse()
	public override func prepareForReuse() {
		super.prepareForReuse()
		controller.cellIsPreparingForReuse()
	}

	// MARK: Unavailable

	/// - SeeAlso: NSCoding.init?(coder:)
	@available(*, unavailable) public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
