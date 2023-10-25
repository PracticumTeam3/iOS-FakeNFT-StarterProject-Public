//
//  PaymentService.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

final class PaymentService {
    static let shared = PaymentService()
    private let urlSession = URLSession.shared
    private var currentTask: URLSessionTask?
    @CartObservable private(set) var currencies = [Currency]()
    
    private enum NetWorkError: Error {
        case codeError
    }
    
    func fetchCurrencies() {
        currentTask?.cancel()
        let request = URLRequest.makeHTTPRequest(
            path: "/api/v1/currencies",
            httpMethod: "GET")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[CurrencyResult],Error>) in
            guard self != nil else { return }
            switch result {
            case.success(let currencyResults):
                let currencies = currencyResults.compactMap { Currency(title: $0.title,
                                                                       name: $0.name,
                                                                       image: $0.image,
                                                                       id: $0.id)}
                self?.currencies = currencies
            case .failure(let error):
                print(error)
            }
        }
        currentTask = task
        currentTask?.resume()
    }
}
