//
//  DetailViewController.swift
//  BrandiAssignment
//
//  Created by 경원이 on 2022/02/28.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    
    let imageView = UIImageView()
    var imageUrl: URL = URL(string: "https://k.kakaocdn.net/dn/bCWrkB/btq7C1ZNuod/NTw3O4khCCVIr6SiUYnrCK/img.png")!
    let labelView = UIView()
    let sitenameLabel = UILabel()
    var sitename = "미상"
    let datetimeLabel = UILabel()
    var datetime = "미상"

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
        sitenameLabel.text = "출처 : \(sitename)"
        sitenameLabel.textColor = .white
        datetimeLabel.font = .systemFont(ofSize: 14)
        datetimeLabel.text = "작성시간 : \(datetime)"
        datetimeLabel.textColor = .white
        view.backgroundColor = .white
        labelView.backgroundColor = .black
        labelView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFit
        DispatchQueue.main.async {
            self.imageView.kf.setImage(with: self.imageUrl)
            
        }

        
       

    }
    
    private func makeConstraints() {
        
        labelView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(140)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(labelView.snp.top).offset(20)
        }
        
        sitenameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        datetimeLabel.snp.makeConstraints { make in
            make.top.equalTo(sitenameLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
        
        
        
    }
    
    

}
