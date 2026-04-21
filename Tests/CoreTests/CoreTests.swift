import Testing
@testable import Core
import Foundation

struct CoreTests {
    @Test func kernelBootstrapsWithBundledDefaultsWhenLocalConfigIsMissing() throws {
        let sessionManager = SessionManager()
        let configURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
            .appendingPathComponent("config.json", isDirectory: false)
        let kernel = try AppKernel(
            configStore: ConfigStore(fileURL: configURL),
            sessionManager: sessionManager
        )

        #expect(type(of: kernel.defaults) == Defaults.self)
        #expect(type(of: kernel.configStore) == ConfigStore.self)
        #expect(kernel.configuration.model.provider == "apple-foundation")
        #expect(kernel.configuration.model.name == "foundation-default")
        #expect(kernel.configuration.mcp.serversFile == "mcp-servers.json")
        #expect(type(of: kernel.auditLog) == AuditLog.self)
        #expect(kernel.sessionManager === sessionManager)
    }

    @Test func configStorePersistsAndLoadsConfiguration() throws {
        let baseURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        let configURL = baseURL.appendingPathComponent("config.json", isDirectory: false)
        let store = ConfigStore(fileURL: configURL)
        let expected = AppConfiguration(
            model: AppConfiguration.Model(provider: "ollama", name: "llama3.2"),
            mcp: AppConfiguration.MCP(serversFile: "config/mcp-servers.json")
        )

        try store.persist(expected)
        let loaded = try store.load()

        #expect(store.fileURL == configURL)
        #expect(loaded == expected)
    }

    @Test func configStoreBootstrapsBundledDefaultsWhenFileDoesNotExist() throws {
        let configURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
            .appendingPathComponent("missing.json", isDirectory: false)
        let store = ConfigStore(fileURL: configURL)
        let configuration = try store.bootstrap(defaults: Defaults())

        #expect(configuration.model.provider == "apple-foundation")
        #expect(configuration.model.name == "foundation-default")
    }

    @Test func configStoreBootstrapsLocalConfigurationWhenFileExists() throws {
        let baseURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        let configURL = baseURL.appendingPathComponent("config.json", isDirectory: false)
        let store = ConfigStore(fileURL: configURL)
        let expected = AppConfiguration(
            model: AppConfiguration.Model(provider: "openai", name: "gpt-5.4"),
            mcp: AppConfiguration.MCP(serversFile: "workspace/mcp-servers.json")
        )

        try store.persist(expected)

        let loaded = try store.bootstrap(defaults: Defaults())

        #expect(loaded == expected)
    }
}
