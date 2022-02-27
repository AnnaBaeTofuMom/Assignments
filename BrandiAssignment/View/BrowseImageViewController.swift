//
//  ViewController.swift
//  BrandiAssignment
//
//  Created by 경원이 on 2022/02/24.
//

import UIKit
import SnapKit
import Kingfisher

class BrowseImageViewController: UIViewController {
    let viewModel = BrowseImageViewModel()
    
    let collectionView: UICollectionView = {
           
           let layout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 10
           layout.scrollDirection = .vertical
           layout.sectionInset = UIEdgeInsets.init(top: 0 , left: 0, bottom: 0, right: 0)
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           
           return cv
       }()
    let searchBar = UISearchController()
    
    override func viewDidLayoutSubviews() {
        viewModel.getImage(word: "이상한 고양이", page: 1) { daumImage, statusCode in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.navigationItem.searchController = searchBar
        self.navigationItem.title = "이미지 검색"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        configure()
        makeConstraints()
    }
    
    func configure() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
        
        
        
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(5)
        }
    }


}

extension BrowseImageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        if viewModel.images.count != 0 {
            let url = URL(string: viewModel.images[indexPath.item].thumbnailURL)
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interval:CGFloat = 5
        let width: CGFloat = ( UIScreen.main.bounds.width - interval * 4 ) / 3
                    return CGSize(width: width , height: width )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    
    
}

