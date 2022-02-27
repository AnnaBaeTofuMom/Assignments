//
//  CollectionViewCell.swift
//  BrandiAssignment
//
//  Created by 경원이 on 2022/02/25.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageCell"
    let imageView = UIImageView()

    
    
    required init?(coder: NSCoder) {
          super.init(coder: coder)
          configure()
          makeConstraints()
      }
      
      override init(frame: CGRect) {
          super.init(frame: .zero)
          configure()
          makeConstraints()
      }
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        imageView.backgroundColor = .blue
        
        
    }
    
    
    func makeConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    

    
    
}
