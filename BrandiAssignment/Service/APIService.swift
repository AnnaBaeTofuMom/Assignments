//
//  APIService.swift
//  Brandi01
//
//  Created by 경원이 on 2022/02/24.
//
import Alamofire
import SwiftyJSON


class APIService {
    
    enum StatusCode : Int {
        case success = 200
        case badRequest = 400
        case serverError = 500
    }
    
   
    
    static func getNewImage(word: String, page: Int, completion: @escaping (DaumImage?, StatusCode?) -> Void) {
        
        let params = [
            "query": word,
            "sort": "accuracy",
            "page": page,
            "size": 30,
        ] as Parameters
        
        let headers = [
            "Authorization": "KakaoAK \(APIKey.apiKey)",
            "Content-Type": ""
        ] as HTTPHeaders
        
        let url = Endpoint.request.url
        
        AF.request(url, method: .get, parameters: params, headers: headers).validate().responseDecodable(of: DaumImage.self) { res in
            print("=================")
            print("this is status code")
            print(res.response?.statusCode)
            print(res.result)
            print("============================================")

            completion(res.value, nil)
        }
        
        
        
        
        
    }
    
    
    
}
