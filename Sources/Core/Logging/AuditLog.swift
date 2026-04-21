import Foundation

public struct AuditEvent: Codable, Equatable, Sendable {
    public enum Category: String, Codable, Sendable {
        case session
        case tool
        case subprocess
    }

    public let schemaVersion: Int
    public let id: UUID
    public let timestamp: Date
    public let category: Category
    public let action: String
    public let subject: String?
    public let metadata: [String: String]

    public init(
        schemaVersion: Int = 1,
        id: UUID = UUID(),
        timestamp: Date = Date(),
        category: Category,
        action: String,
        subject: String? = nil,
        metadata: [String: String] = [:]
    ) {
        self.schemaVersion = schemaVersion
        self.id = id
        self.timestamp = timestamp
        self.category = category
        self.action = action
        self.subject = subject
        self.metadata = metadata
    }
}

public struct AuditLog: Sendable {
    public private(set) var events: [AuditEvent]

    public init(events: [AuditEvent] = []) {
        self.events = events
    }

    @discardableResult
    public mutating func record(_ event: AuditEvent) -> AuditEvent {
        events.append(event)
        return event
    }

    @discardableResult
    public mutating func record(
        category: AuditEvent.Category,
        action: String,
        subject: String? = nil,
        metadata: [String: String] = [:],
        timestamp: Date = Date(),
        id: UUID = UUID()
    ) -> AuditEvent {
        let event = AuditEvent(
            id: id,
            timestamp: timestamp,
            category: category,
            action: action,
            subject: subject,
            metadata: metadata
        )
        return record(event)
    }
}
