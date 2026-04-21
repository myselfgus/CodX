import Foundation

public struct AppConfiguration: Codable, Equatable, Sendable {
    public struct Model: Codable, Equatable, Sendable {
        public let provider: String
        public let name: String

        public init(provider: String, name: String) {
            self.provider = provider
            self.name = name
        }
    }

    public struct MCP: Codable, Equatable, Sendable {
        public let serversFile: String

        public init(serversFile: String) {
            self.serversFile = serversFile
        }
    }

    public let model: Model
    public let mcp: MCP

    public init(model: Model, mcp: MCP) {
        self.model = model
        self.mcp = mcp
    }
}

public struct Defaults: Sendable {
    public enum DefaultsError: Error, LocalizedError, Equatable, Sendable {
        case resourceNotFound(String)
        case readFailed(String, String)
        case decodeFailed(String, String)

        public var errorDescription: String? {
            switch self {
            case .resourceNotFound(let resourceName):
                "Default config resource not found: \(resourceName)"
            case .readFailed(let resourceName, let reason):
                "Failed to read default config resource \(resourceName): \(reason)"
            case .decodeFailed(let resourceName, let reason):
                "Failed to decode default config resource \(resourceName): \(reason)"
            }
        }
    }

    public let resourceName: String
    public let resourceExtension: String
    private let bundle: Bundle

    public init() {
        self.init(
            bundle: .module,
            resourceName: "default-config",
            resourceExtension: "json"
        )
    }

    init(
        bundle: Bundle,
        resourceName: String,
        resourceExtension: String
    ) {
        self.bundle = bundle
        self.resourceName = resourceName
        self.resourceExtension = resourceExtension
    }

    public func loadConfiguration() throws -> AppConfiguration {
        guard let resourceURL = bundle.url(
            forResource: resourceName,
            withExtension: resourceExtension
        ) else {
            throw DefaultsError.resourceNotFound(resourceFileName)
        }

        let data: Data
        do {
            data = try Data(contentsOf: resourceURL)
        } catch {
            throw DefaultsError.readFailed(resourceFileName, error.localizedDescription)
        }

        do {
            return try JSONDecoder().decode(AppConfiguration.self, from: data)
        } catch {
            throw DefaultsError.decodeFailed(resourceFileName, error.localizedDescription)
        }
    }

    private var resourceFileName: String {
        "\(resourceName).\(resourceExtension)"
    }
}
