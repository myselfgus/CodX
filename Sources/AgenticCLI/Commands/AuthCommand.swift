import ArgumentParser

struct AuthCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Manage provider credentials.",
        subcommands: [Add.self, Remove.self, List.self]
    )
}

extension AuthCommand {
    struct Add: AsyncParsableCommand {
        @Argument var provider: String
        mutating func run() async throws {}
    }

    struct Remove: AsyncParsableCommand {
        @Argument var provider: String
        mutating func run() async throws {}
    }

    struct List: AsyncParsableCommand {
        mutating func run() async throws {}
    }
}
