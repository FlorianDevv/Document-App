//
//  DocumentViewController.swift
//  Document App
//
//  Created by Florian PICHON on 17/01/2024.
//

import UIKit

class DocumentViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageName = imageName {
            imageView.image = UIImage(named: imageName)
        }
    }
}
