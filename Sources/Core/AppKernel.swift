public struct AppKernel: Sendable {
    public let defaults: Defaults
    public let configStore: ConfigStore
    public let auditLog: AuditLog
    public let sessionManager: SessionManager

    public init(
        defaults: Defaults = Defaults(),
        configStore: ConfigStore = ConfigStore(),
        auditLog: AuditLog = AuditLog(),
        sessionManager: SessionManager = SessionManager()
    ) {
        self.defaults = defaults
        self.configStore = configStore
        self.auditLog = auditLog
        self.sessionManager = sessionManager
    }
}
