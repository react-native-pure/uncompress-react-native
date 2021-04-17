//
//  ExtractUseCase.swift
//  Uncompress
//
//  Created by Adriano Souza Costa on 17/03/21.
//

import Foundation

public protocol ExtractUseCaseProtocol {
    var engines: [Extractable] { get }
}

public extension ExtractUseCaseProtocol {

    var compatibilities: [Compatibility] {
        return engines.flatMap { $0.compatibilities }
    }

    func run(
        _ filePath: String,
        to destination: String,
        overwrite: Bool,
        password: String? = nil
    ) throws {
        guard let filePathUrl = URL(string: filePath) else {
            throw "The file path is invalid"
        }

        guard let destinationUrl = URL(string: destination) else {
            throw "The destination path is invalid"
        }

        let engine = try selectEngineAt(fileExtension: filePathUrl.pathExtension)

        try engine.extract(
            filePathUrl,
            to: destinationUrl,
            overwrite: overwrite,
            password: password
        )
    }

    private func selectEngineAt(fileExtension: String) throws -> Extractable {
        if let compatibility = Compatibility(rawValue: fileExtension),
           let engine = engines.first(where: { (engine) -> Bool in
            return engine.compatibilities.contains(compatibility)
        }) {
            return engine
        }

        throw "Does not have a \(fileExtension) extension engine"
    }

}

public final class ExtractUseCase: ExtractUseCaseProtocol {

    // MARK: - Public Properties

    private(set) public var engines: [Extractable]

    // MARK: - Public Methods

    public init(engines: [Extractable]) {
        self.engines = engines
    }

}
