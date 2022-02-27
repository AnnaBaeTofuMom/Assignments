//
//  BrowseImageViewModel.swift
//  BrandiAssignment
//
//  Created by 경원이 on 2022/02/25.
//

import Foundation

class BrowseImageViewModel {
    
    var images: [Document] = []
    var pageCount = 1
    var isEnd: Bool = false
    var pagination: Bool = false
    
    
    
    func getImage(word: String, completion: @escaping (DaumImage?, APIService.StatusCode?) -> Void) {
        if isEnd {
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            APIService.getNewImage(word: word, page: self.pageCount) { daumImage, statuscode in
                if let daumImage = daumImage {
                    self.images += daumImage.documents
                    self.isEnd = daumImage.meta.isEnd
                    self.pageCount += 1
                    completion(daumImage, nil)
                }
                
                print(self.images.count)
                print("이만큼 있음")
            }
        }
    }
    
    func clearCollectionView() {
        images = []
        pageCount = 1
    }
}
