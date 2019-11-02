//
//  ItemDetailsViewController.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public var viewModel: ItemDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fillView()
    }
    
    @objc private func didTapImageView() {
        let fullScreenViewController: FullScreenImageViewController = FullScreenImageViewController()
        fullScreenViewController.loadImage(withURL: viewModel?.getImageURL() ?? "")
        let navController: UINavigationController = UINavigationController(rootViewController: fullScreenViewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    // MARK: - PRIVATE
    
    private func setupView() {
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 24)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont(name: "Helvetica", size: 18)
        descriptionLabel.textColor = .lightText
        descriptionLabel.numberOfLines = 0
        
        self.view.backgroundColor = .darkGray
        self.bottomContainerView.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ItemDetailsViewController.didTapImageView)))
        imageView.isUserInteractionEnabled = true
    }
    
    private func fillView() {
        guard let viewModel = viewModel else { return }
        
        imageView.download(from: viewModel.getImageURL(), contentMode: .scaleAspectFit, completionHandler: nil)
        titleLabel.text = viewModel.getTitle()
        descriptionLabel.text = viewModel.getDescription()
        
        titleLabel.sizeToFit()
        descriptionLabel.sizeToFit()
        
        view.setNeedsLayout()
    }
}
