import Logging

public enum Log {
    public static let subsystem = "codx"

    public static func bootstrap() {
        _ = bootstrapToken
    }

    public static func logger(scope: String) -> Logger {
        bootstrap()
        return Logger(label: label(for: scope))
    }

    public static func logger(for type: Any.Type) -> Logger {
        logger(scope: String(describing: type))
    }

    private static let bootstrapToken: Void = {
        LoggingSystem.bootstrap(StreamLogHandler.standardError)
    }()

    private static func label(for scope: String) -> String {
        guard !scope.isEmpty else {
            return subsystem
        }

        return "\(subsystem).\(scope)"
    }
}
