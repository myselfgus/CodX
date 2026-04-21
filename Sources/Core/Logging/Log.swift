import Logging

public enum Log {
    public static func bootstrap() {
        LoggingSystem.bootstrap(StreamLogHandler.standardOutput)
    }
}
