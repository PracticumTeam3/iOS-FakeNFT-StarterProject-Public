//
//  CartObservable.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 10.10.2023.
//

import Foundation
@propertyWrapper
class CartObservable<Value> {
    
    private var onChange: ((Value) -> Void)? = nil
    
    var wrappedValue: Value {
        didSet {
            onChange?(wrappedValue)
        }
    }
    
    var projectedValue: CartObservable<Value> {
        return self
    }
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    func bind(action: @escaping (Value) -> Void) {
        self.onChange = action
    }
    
}
