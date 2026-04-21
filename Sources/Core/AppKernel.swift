public struct AppKernel: Sendable {
    public let defaults: Defaults
    public let configStore: ConfigStore
    public let configuration: AppConfiguration
    public let auditLog: AuditLog
    public let sessionManager: SessionManager

    public init(
        defaults: Defaults = Defaults(),
        configStore: ConfigStore = ConfigStore(),
        auditLog: AuditLog = AuditLog(),
        sessionManager: SessionManager = SessionManager()
    ) throws {
        self.defaults = defaults
        self.configStore = configStore
        self.configuration = try configStore.bootstrap(defaults: defaults)
        self.auditLog = auditLog
        self.sessionManager = sessionManager
    }
}
