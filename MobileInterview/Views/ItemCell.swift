//
//  ItemCell.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public var item: Item? {
        didSet {
            guard let item = item else { return }
            
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            thumbnailImageView.download(from: item.imageURL, contentMode: .scaleAspectFill, completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = UIImage(named: "image-placeholder")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let imageSize: CGFloat = thumbnailImageView.bounds.height + 16
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        let textsWidth: CGFloat = size.width - imageSize - 8
        let maxHeight: CGFloat = max(imageSize, calculateTextsHeight(forWidth: textsWidth))
        frame.size.height = ceil(maxHeight)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    // MARK: - PRIVATE
    
    private func setupCell() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        titleLabel.textColor = .darkText
        
        descriptionLabel.numberOfLines = 3
        descriptionLabel.font = UIFont(name: "Helvetica", size: 16)
        descriptionLabel.textColor = .lightGray
        
        thumbnailImageView.image = UIImage(named: "image-placeholder")
        thumbnailImageView.roundCorners(corners: .allCorners, withRadius: Double(thumbnailImageView.bounds.width / 2))
        thumbnailImageView.layer.borderWidth = 2.0
        thumbnailImageView.layer.borderColor = UIColor.black.cgColor
    }
    
    private func calculateTextsHeight(forWidth width: CGFloat) -> CGFloat {
        guard let item = item else { return 0.0 }
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let titleFont: UIFont = titleLabel.font ?? UIFont.systemFont(ofSize: 20)
        let titleBounds = item.title.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: titleFont], context: nil)
        let descriptionFont: UIFont = descriptionLabel.font ?? UIFont.systemFont(ofSize: 16)
        let descriptionBounds = item.description.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: descriptionFont], context: nil)
        // Calculate the maximum number of lines height
        let descriptionMaxHeight: CGFloat = min(descriptionBounds.height, descriptionFont.pointSize * 3)
        // Return the addition of both texts plus the margins and spacing
        return titleBounds.height + descriptionMaxHeight + 24
    }
}
