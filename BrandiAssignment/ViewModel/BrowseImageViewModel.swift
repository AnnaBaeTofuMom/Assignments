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
    var noResult: Observable<Bool> = Observable(false)
    
    
    
    func getImage(word: String, completion: @escaping (DaumImage?, Int?) -> Void) {
        if isEnd {
            clearCollectionView()
            return
        } else {
            clearCollectionView()
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                APIService.getNewImage(word: word, page: self.pageCount) { daumImage, statuscode in
                    switch statuscode {
                    case 200:
                        if let daumImage = daumImage {
                            self.images += daumImage.documents
                            self.isEnd = daumImage.meta.isEnd
                            self.pageCount += 1
                            completion(daumImage, statuscode)
                        }
                        
                        if self.images.count == 0 {
                            self.noResult.value = true
                        }
                    case 400:
                        completion(nil, statuscode)
                        
                    case .none:
                        completion(nil, nil)
                    case .some(_):
                        completion(nil, nil)
                    }

                    
                }
            }
        }
        
    }
    
    func addImage(word: String, completion: @escaping (DaumImage?, Int?) -> Void) {
        if isEnd {
            return
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            APIService.getNewImage(word: word, page: self.pageCount) { daumImage, statuscode in
                if let daumImage = daumImage {
                    self.images += daumImage.documents
                    self.isEnd = daumImage.meta.isEnd
                    self.pageCount += 1
                    completion(daumImage, statuscode)
                }
                
                print(self.images.count)
                print("이만큼 있음")
            }
        }
    }
    
    func clearCollectionView() {
        images = []
        pageCount = 1
        isEnd = false
        noResult.value = false
    }
}
