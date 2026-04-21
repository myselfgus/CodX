import Foundation

public struct ConfigStore: Sendable {
    public enum StoreError: Error, LocalizedError, Equatable, Sendable {
        case fileNotFound(URL)
        case readFailed(URL, String)
        case decodeFailed(URL, String)
        case encodeFailed(URL, String)
        case writeFailed(URL, String)

        public var errorDescription: String? {
            switch self {
            case .fileNotFound(let url):
                "Config file not found at \(url.path)"
            case .readFailed(let url, let reason):
                "Failed to read config at \(url.path): \(reason)"
            case .decodeFailed(let url, let reason):
                "Failed to decode config at \(url.path): \(reason)"
            case .encodeFailed(let url, let reason):
                "Failed to encode config for \(url.path): \(reason)"
            case .writeFailed(let url, let reason):
                "Failed to write config at \(url.path): \(reason)"
            }
        }
    }

    public let fileURL: URL

    public init(
        fileURL: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appendingPathComponent("config.json", isDirectory: false)
    ) {
        self.fileURL = fileURL
    }

    public func bootstrap(defaults: Defaults) throws -> AppConfiguration {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return try defaults.loadConfiguration()
        }

        return try load()
    }

    public func load() throws -> AppConfiguration {
        let data = try readData()
        return try decode(AppConfiguration.self, from: data)
    }

    public func persist(_ configuration: AppConfiguration) throws {
        let data = try encode(configuration)
        try write(data)
    }

    private func decode<Configuration: Decodable>(
        _ type: Configuration.Type,
        from data: Data
    ) throws -> Configuration {
        do {
            return try JSONDecoder().decode(Configuration.self, from: data)
        } catch {
            throw StoreError.decodeFailed(fileURL, error.localizedDescription)
        }
    }

    private func encode<Configuration: Encodable>(_ configuration: Configuration) throws -> Data {
        do {
            return try JSONEncoder().encode(configuration)
        } catch {
            throw StoreError.encodeFailed(fileURL, error.localizedDescription)
        }
    }

    private func write(_ data: Data) throws {
        do {
            let directoryURL = fileURL.deletingLastPathComponent()
            try FileManager.default.createDirectory(
                at: directoryURL,
                withIntermediateDirectories: true
            )
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            throw StoreError.writeFailed(fileURL, error.localizedDescription)
        }
    }

    private func readData() throws -> Data {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw StoreError.fileNotFound(fileURL)
        }

        do {
            return try Data(contentsOf: fileURL)
        } catch {
            throw StoreError.readFailed(fileURL, error.localizedDescription)
        }
    }
}
