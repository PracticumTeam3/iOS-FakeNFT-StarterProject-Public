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
            path: CartNetworkPath.paymentService.rawValue)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[CurrencyNetwork],Error>) in
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
    
    func payOrder(_ currencyID: String, completion: @escaping (Result <ResultOrder, Error>) -> Void) {
        let request = URLRequest.makeHTTPRequest(
            path: CartNetworkPath.currencyPay.rawValue + currencyID)
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ResultOrderNetwork, Error>) in
            guard self != nil else { return }
            switch result {
            case .success(let resultOrderNetwork):
                let resultOrder = ResultOrder(success: resultOrderNetwork.success,
                                              orderId: resultOrderNetwork.orderId,
                                              currencyId: resultOrderNetwork.currencyId)
                completion(.success(resultOrder))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
