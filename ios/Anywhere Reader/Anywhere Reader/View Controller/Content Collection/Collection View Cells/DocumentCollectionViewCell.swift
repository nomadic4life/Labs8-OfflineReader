//
//  DocumentCollectionViewCell.swift
//  Anywhere Reader
//
//  Created by Samantha Gatt on 11/6/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class DocumentCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var article: Article? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var documentTypeLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var blurLayer: UIVisualEffectView!
    @IBOutlet weak var shadowView: ShadowView!
    
    // MARK: - Functions
    func updateViews() {
        guard let article = article else { return }
        
        do {
            let url = URL(string: article.coverImage)!
            let data = try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        }
        catch {
            NSLog("Error setting image")
        }
        
        titleLabel.text = article.title
        
        let cornerRadius: CGFloat = 20.0
        shadowView.cornerRadius = cornerRadius
        shadowView.layer.shadowOpacity = 0.09
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 7)
        shadowView.layer.shadowRadius = 2
        blurLayer.layer.cornerRadius = cornerRadius
        imageView.layer.cornerRadius = cornerRadius
        
        openButton.layer.cornerRadius = openButton.frame.height / 2.0
    }
}
