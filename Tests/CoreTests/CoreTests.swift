import Testing
@testable import Core
import Foundation

struct CoreTests {
    @Test func kernelBootstraps() {
        let sessionManager = SessionManager()
        let kernel = AppKernel(sessionManager: sessionManager)

        #expect(type(of: kernel.defaults) == Defaults.self)
        #expect(type(of: kernel.configStore) == ConfigStore.self)
        #expect(type(of: kernel.auditLog) == AuditLog.self)
        #expect(kernel.sessionManager === sessionManager)
    }

    @Test func configStorePersistsAndLoadsConfiguration() throws {
        let baseURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        let configURL = baseURL.appendingPathComponent("config.json", isDirectory: false)
        let store = ConfigStore(fileURL: configURL)
        let expected = TestConfiguration(model: "local-model", sessionLimit: 4)

        try store.persist(expected)
        let loaded = try store.load(TestConfiguration.self)

        #expect(store.fileURL == configURL)
        #expect(loaded == expected)
    }

    @Test func configStoreFailsExplicitlyWhenFileDoesNotExist() {
        let configURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
            .appendingPathComponent("missing.json", isDirectory: false)
        let store = ConfigStore(fileURL: configURL)

        #expect(throws: ConfigStore.StoreError.fileNotFound(configURL)) {
            try store.load(TestConfiguration.self)
        }
    }
}

private struct TestConfiguration: Codable, Equatable {
    let model: String
    let sessionLimit: Int
}
