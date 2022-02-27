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
    
    
    
    func getImage(word: String, page: Int, completion: @escaping (DaumImage?, APIService.StatusCode?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            APIService.getNewImage(word: word, page: page) { daumImage, statuscode in
                if let daumImage = daumImage {
                    self.images = daumImage.documents
                    completion(daumImage, nil)
                }
                
                print(self.images.count)
                print("이만큼 있음")
            }
        }
       
       
        
    }
    
    
    
}
