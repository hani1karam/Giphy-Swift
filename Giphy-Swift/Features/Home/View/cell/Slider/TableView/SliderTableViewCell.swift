//
//  SliderTableViewCell.swift
//  Giphy-Swift
//
//  Created by Hany Karam on 25/12/2022.
//

import UIKit

class SliderTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var categoriesList = [HomeResponseDataModel]()
    var didSelectItem: ((HomeResponseDataModel) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupCollectionView(){
        collectionview.register(UINib(nibName: CellIdnetifiers.SliderCollectionViewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: CellIdnetifiers.SliderCollectionViewCell.rawValue)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.reloadData()
    }
    func fillData(list: [HomeResponseDataModel]) {
        categoriesList = list
        setupCollectionView()
        checkBanner()
        if list.count == 1{
            pageControl.numberOfPages = 0
        }else{
            pageControl.numberOfPages = list.count
        }
        
        pageControl.addTarget(self, action: #selector(changePage), for: .valueChanged)
        pageControl.isHidden = false
    }
    func checkBanner() {
        categoriesList.count > 1 ? (pageControl.isHidden = false) : (pageControl.isHidden = true)
    }
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * collectionview.frame.size.width
        collectionview.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdnetifiers.SliderCollectionViewCell.rawValue, for: indexPath) as! SliderCollectionViewCell
        cell.reloadImage(image: categoriesList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionview.frame.width, height: collectionview.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(categoriesList[indexPath.item])
    }
}
