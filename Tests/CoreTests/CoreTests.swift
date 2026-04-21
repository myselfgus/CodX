import Testing
@testable import Core
import Foundation

struct CoreTests {
    @Test func logBuildsUsableOperationalLogger() {
        Log.bootstrap()
        Log.bootstrap()

        var scopedLogger = Log.logger(scope: "session")
        scopedLogger.logLevel = .debug
        scopedLogger[metadataKey: "session.id"] = "abc123"

        let typedLogger = Log.logger(for: SessionManager.self)

        #expect(scopedLogger.logLevel == .debug)
        #expect(scopedLogger[metadataKey: "session.id"] == "abc123")
        #expect(typedLogger.logLevel == .info)
    }

    @Test func auditLogRecordsPredictableEvents() {
        var auditLog = AuditLog()
        let expectedID = UUID(uuidString: "AAAAAAAA-BBBB-CCCC-DDDD-EEEEEEEEEEEE")!
        let expectedTimestamp = Date(timeIntervalSince1970: 1_715_000_000)

        let event = auditLog.record(
            category: .tool,
            action: "execute",
            subject: "shell.ls",
            metadata: ["exit_code": "0", "session_id": "s-123"],
            timestamp: expectedTimestamp,
            id: expectedID
        )

        #expect(event.schemaVersion == 1)
        #expect(event.id == expectedID)
        #expect(event.timestamp == expectedTimestamp)
        #expect(event.category == .tool)
        #expect(event.action == "execute")
        #expect(event.subject == "shell.ls")
        #expect(event.metadata == ["exit_code": "0", "session_id": "s-123"])
        #expect(auditLog.events == [event])
    }

    @Test func auditEventIsCodableWithStableShape() throws {
        let event = AuditEvent(
            id: UUID(uuidString: "11111111-2222-3333-4444-555555555555")!,
            timestamp: Date(timeIntervalSince1970: 1_700_000_000),
            category: .session,
            action: "started",
            subject: "session-abc",
            metadata: ["source": "cli"]
        )

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        encoder.dateEncodingStrategy = .iso8601

        let encoded = try encoder.encode(event)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(AuditEvent.self, from: encoded)

        #expect(decoded == event)

        let json = String(decoding: encoded, as: UTF8.self)
        #expect(json.contains("\"schemaVersion\":"))
        #expect(json.contains("\"category\":\"session\""))
        #expect(json.contains("\"action\":\"started\""))
        #expect(json.contains("\"subject\":\"session-abc\""))
        #expect(json.contains("\"metadata\":{"))
    }

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
