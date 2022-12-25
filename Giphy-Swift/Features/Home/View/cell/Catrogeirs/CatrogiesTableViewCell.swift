//
//  CatrogiesTableViewCell.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 24/12/2022.
//

import UIKit
import SDWebImage
class CatrogiesTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCatrogies: UIImageView!
    @IBOutlet weak var titleCatrogies: UILabel!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var homeView: UIView!
    
    static var identifier: String { return String(describing: self) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.white
        homeView.layer.cornerRadius = 15.0
        homeView.layer.masksToBounds = false
        homeView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        homeView.layer.shadowOffset = CGSize(width: 0, height: 0)
        homeView.layer.shadowOpacity = 0.8
        homeView.staticShadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(with item: HomeResponseDataModel){
        titleCatrogies.text = item.title
        nameUser.text = item.username
        if let img = URL(string: item.images?.downsized?.url ?? ""){
            DispatchQueue.main.async {
                self.imageCatrogies.sd_setImage(with: img,placeholderImage: UIImage(named: ""))
            }
        }
    }
}
