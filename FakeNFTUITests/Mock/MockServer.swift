//
//  MockServer.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

import Swifter

// MARK: - MockServer
final class MockServer {

    var config: [MockServerConfig] = [] {
        didSet {
            configure()
        }
    }

    // MARK: - Private properties
    private let server: HttpServer
    private let jsonEncoder: JSONEncoder

    // MARK: - Initializers
    init(
        server: HttpServer = HttpServer(),
        jsonEncoder: JSONEncoder = JSONEncoder()
    ) {
        self.server = server
        self.jsonEncoder = jsonEncoder
    }

    // MARK: - Public methods
    func launch() {
        do {
            try server.start(9080, forceIPv4: true)
        } catch {
            fatalError("Server is not started. Error: \(error)")
        }
    }

    func stop() {
        server.stop()
    }

    // MARK: - Private methods
    private func configure() {
        for el in config {
            switch el.method {
            case .get:
                server.GET[el.path] = { _ in
                    .ok(.json(el.json))
                }
            case .put:
                server.PUT[el.path] = { _ in
                    .ok(.json(el.json))
                }
            }
        }
    }

}
