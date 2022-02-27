//
//  Observable.swift
//  BrandiAssignment
//
//  Created by 경원이 on 2022/02/28.
//

import Foundation

class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ){
        closure(value)
        listener = closure
    }
}
