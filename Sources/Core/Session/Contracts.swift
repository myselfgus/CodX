import Foundation

public struct ModelInfo: Sendable {
    public let id: String
    public let displayName: String
}

public struct ChatTurnRequest: Sendable {
    public let sessionID: String
    public let prompt: String
}

public struct UsageDelta: Sendable {
    public let inputTokens: Int
    public let outputTokens: Int
}

public enum FinishReason: Sendable {
    case stop
    case toolUse
    case canceled
}

public struct ToolCall: Sendable {
    public let id: String
    public let name: String
}

public enum ProviderEvent: Sendable {
    case started
    case deltaText(String)
    case toolCallRequested(ToolCall)
    case usage(UsageDelta)
    case finished(FinishReason)
}

public struct ToolSchema: Sendable {
    public let jsonSchema: String
}

public enum JSONValue: Sendable {
    case string(String)
    case number(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    case null
}

public struct ToolContext: Sendable {
    public let sessionID: String
}

public struct ToolResult: Sendable {
    public let output: String
}

public struct SessionRecord: Sendable {
    public let id: String
}

public struct MessageRecord: Sendable {
    public let id: String
    public let sessionID: String
}

public struct SessionSnapshot: Sendable {
    public let session: SessionRecord
    public let messages: [MessageRecord]
}

public protocol LLMProvider: Sendable {
    var id: String { get }
    func listModels(forceRefresh: Bool) async throws -> [ModelInfo]
    func stream(request: ChatTurnRequest) -> AsyncThrowingStream<ProviderEvent, Error>
    func estimateCost(model: String, inputTokens: Int, outputTokens: Int) -> Decimal?
}

public protocol Tool: Sendable {
    var name: String { get }
    var schema: ToolSchema { get }
    func execute(_ input: JSONValue, context: ToolContext) async throws -> ToolResult
}

public protocol SessionStore: Sendable {
    func createSession(_ session: SessionRecord) async throws
    func appendMessage(_ message: MessageRecord) async throws
    func listSessions(limit: Int) async throws -> [SessionRecord]
    func loadSession(id: String) async throws -> SessionSnapshot
}
