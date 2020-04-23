//
//  HNImageView.swift
//  HackerNews
//
//  Created by Никита Васильев on 20.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Kingfisher

final class HNImageView: UIView {
    
    // MARK: Private Properties
    private var downloadTask: DownloadTask?
    private var imageView: UIImageView = UIImageView()
    
    // MARK: Public Properties
    
    /// <#Description#>
    var cornerRadius: CGFloat = 8.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: Intitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Public Methods
    
    /// <#Description#>
    ///
    /// - Parameter url: <#url description#>
    ///
    /// - Returns: <#description#>
    func setImage(from url: URL?) {
        setPlaceholder()
        
        guard let url = url, let thumbnailURL = URL(string: Constants.Links.imageExtractorURL + (url.absoluteString)) else {
            return
        }
        
        let newSize = 60
        let thumbnailSize = CGFloat(newSize) * UIScreen.main.scale
        let thumbnailCGSize = CGSize(width: thumbnailSize, height: thumbnailSize)
        let imageSizeProcessor = ResizingImageProcessor(referenceSize: thumbnailCGSize,
                                                        mode: .aspectFill)
        let options: KingfisherOptionsInfo = [
            .processor(imageSizeProcessor)
        ]

        let resource = ImageResource(downloadURL: thumbnailURL)

        downloadTask = KingfisherManager.shared.retrieveImage(with: resource, options: options) { result in
            switch result {
            case .success(let imageResult):
                DispatchQueue.main.async {
                    self.contentMode = .scaleAspectFill
                    self.imageView.image = imageResult.image
                }
            default: break
            }
        }
    }
    
    /// <#Description#>
    func cancel() {
        downloadTask?.cancel()
    }
    
    // MARK: Private Methods
    
    /// <#Description#>
    private func setup() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        layer.cornerRadius = cornerRadius
    }
    
    private func setPlaceholder() {
        let placeholderImage = R.image.ask()
        
        DispatchQueue.main.async {
            self.contentMode = .center
            self.imageView.image = placeholderImage
        }
    }
}
