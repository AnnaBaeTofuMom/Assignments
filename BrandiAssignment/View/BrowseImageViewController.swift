//
//  ViewController.swift
//  BrandiAssignment
//
//  Created by 경원이 on 2022/02/24.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa
import NotificationBannerSwift

class BrowseImageViewController: UIViewController {
    let viewModel = BrowseImageViewModel()
    let disposeBag = DisposeBag()
    var scrollFlag = true
    let collectionView: UICollectionView = {
           
           let layout = UICollectionViewFlowLayout()
           layout.minimumLineSpacing = 10
           layout.scrollDirection = .vertical
           layout.sectionInset = UIEdgeInsets.init(top: 0 , left: 0, bottom: 0, right: 0)
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           
           return cv
       }()
    let searchBar = UISearchController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.searchController = searchBar
        self.navigationItem.title = "이미지 검색"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        searchBar.searchBar.delegate = self
        configure()
        makeConstraints()
    }
    
    func configure() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
        collectionView.backgroundColor = .clear
        
        
        viewModel.noResult.bind { b in
            if b == true {
                
                self.showBanner(title: "검색결과가 없습니다!", subtitle: "다른 키워드로 검색해 보세요.")
                
               
            }
        }
        
        searchBar.searchBar.rx.text.orEmpty.debounce(.seconds(1), scheduler: MainScheduler.asyncInstance).subscribe { text in
            self.viewModel.getImage(word: text) { daumImage, statuscode in
                switch statuscode {
                case 200:
                    self.scrollFlag = false
                    self.collectionView.reloadData()
                case 400:
                    self.scrollFlag = false
                    self.collectionView.reloadData()
                case .none:
                    self.showBanner(title: "검색에 실패했습니다.", subtitle: "잠시 후 다시 요청해주세요")
                case .some(_):
                    self.showBanner(title: "검색에 실패했습니다.", subtitle: "잠시 후 다시 요청해주세요")
                }
                
                
            }
        }.disposed(by: disposeBag)


        
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    func showBanner(title: String, subtitle: String) {
        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle, style: .warning)
        banner.show()
        
    }


}

extension BrowseImageViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UISearchBarDelegate{
  
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearCollectionView()
        collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let dvc = DetailViewController()
        let url = URL(string: viewModel.images[indexPath.item].imageURL)
        dvc.imageUrl = url!
        dvc.sitename = self.viewModel.images[indexPath.item].displaySitename
        dvc.datetime = self.viewModel.images[indexPath.item].datetime
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.viewModel.images.count == 0 {
            return
        }
        let position = scrollView.contentOffset.y
    
        if position < (collectionView.contentSize.height-100-scrollView.frame.size.height) {
            scrollFlag = false
        } else {
            if scrollFlag == false {
                self.viewModel.addImage(word: self.searchBar.searchBar.text ?? "") { daumImage, statusCode in
                    self.collectionView.reloadData()
                                    }
                scrollFlag = true
            }

        }
        
    }
    
    
    
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

