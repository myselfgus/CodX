public actor SessionManager {
    private var sessions: [String: SessionState] = [:]

    public init() {}

    public func upsert(_ state: SessionState) {
        sessions[state.id] = state
    }

    public func session(id: String) -> SessionState? {
        sessions[id]
    }
}
