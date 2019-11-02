//
//  FullScreenImageViewController.swift
//  MobileInterview
//
//  Created by Ezequiel Facundo Munz on 01/11/2019.
//  Copyright © 2019 Ezequiel Munz. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    private var imageURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(FullScreenImageViewController.didTapCloseButton))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageView.download(from: imageURL, contentMode: .scaleAspectFill, completionHandler: nil)
    }
    
    public func loadImage(withURL urlString: String) {
        imageURL = urlString
    }

    // MARK: - PRIVATE
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
