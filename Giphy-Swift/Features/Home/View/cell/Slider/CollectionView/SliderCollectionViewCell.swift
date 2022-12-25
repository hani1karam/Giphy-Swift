//
//  SliderCollectionViewCell.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 25/12/2022.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageSlider: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func reloadImage(image: HomeResponseDataModel) {
        if let img = URL(string: image.images?.downsized?.url ?? ""){
            DispatchQueue.main.async {
                self.imageSlider.sd_setImage(with: img,placeholderImage: UIImage(named: ""))
            }
        }
    }
}
