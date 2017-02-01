//
//  LanguagesCollectionViewController.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

final class LanguagesCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(LanguageCollectionViewCell.self, forCellWithReuseIdentifier: LanguageCollectionViewCell.identifier)
    }
}
