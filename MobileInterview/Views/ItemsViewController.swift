//
//  ViewController.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {
    
    @IBOutlet weak var aCollectionView: UICollectionView!
    
    public var viewModel: ItemsViewModel = DefaultItemsViewModel()
    
    private var orientation: UIInterfaceOrientation = .portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewModel()
        setupCollectionView()
        
        self.title = "ITEMS"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchItems()
        
        if self.view.bounds.height > self.view.bounds.width {
            orientation = .portrait
        } else {
            orientation = .landscapeLeft
        }
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.orientation = toInterfaceOrientation
        
        aCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - PRIVATE
    
    private func setupViewModel() {
        viewModel.itemsUpdateHandler = { [weak self] in
            self?.aCollectionView.reloadData()
        }
        
        viewModel.errorHandler = { [weak self] message in
            self?.showAlert(withTitle: "Error", message: message)
        }
    }
    
    private func setupCollectionView() {
        aCollectionView.dataSource = self
        aCollectionView.delegate = self
        
        aCollectionView.contentInsetAdjustmentBehavior = .always
        
        aCollectionView.register(cell: ItemCell.self)
    }
}

class CustomFlowLayout: UICollectionViewFlowLayout {
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
}

// MARK: - COLLECTION VIEW DATA SOURCE

extension ItemsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(in: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItem(at: indexPath, collectionView: collectionView)
    }
}

// MARK: - COLLECTION VIEW DELEGATE

extension ItemsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = viewModel.items[safe: indexPath.row] else { return }
        
        let detailsViewController: ItemDetailsViewController = ItemDetailsViewController(nibName: "ItemDetailsViewController", bundle: nil)
        let detailsViewModel: ItemDetailsViewModel = DefaultItemDetailsViewModel(item: item)
        
        detailsViewController.viewModel = detailsViewModel
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: Int = orientation == .portrait ? 1 : 2
        let contentWidth: CGFloat = collectionView.bounds.width - collectionView.safeAreaInsets.horizontalInsets - CGFloat(20 * itemsPerRow)
        return CGSize(width: contentWidth / CGFloat(itemsPerRow), height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
