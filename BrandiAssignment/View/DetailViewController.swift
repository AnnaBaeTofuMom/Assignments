//
//  DetailViewController.swift
//  BrandiAssignment
//
//  Created by 경원이 on 2022/02/28.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    let imageView = UIImageView()
    let labelView = UIView()
    let sitenameLabel = UILabel()
    let datetimeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        [imageView, labelView].forEach { $0
            view.addSubview($0)
        }
        
        [sitenameLabel, datetimeLabel].forEach { $0
            labelView.addSubview($0)
        }
        
        configure()
        makeConstraints()
    
        
    }
    
    private func configure() {
        sitenameLabel.font = .systemFont(ofSize: 14)
        datetimeLabel.font = .systemFont(ofSize: 14)
        labelView.backgroundColor = .black
        labelView.layer.cornerRadius = 16
        imageView.image = UIImage(systemName: "person")
    }
    
    private func makeConstraints() {
        
        labelView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(labelView.snp.top).offset(20)
        }
        
        
        
    }

}
