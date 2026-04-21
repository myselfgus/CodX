import ArgumentParser

struct ModelCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "List and refresh available models.",
        subcommands: [List.self, Refresh.self]
    )
}

extension ModelCommand {
    struct List: AsyncParsableCommand {
        mutating func run() async throws {}
    }

    struct Refresh: AsyncParsableCommand {
        @Option(name: .shortAndLong) var provider: String?
        mutating func run() async throws {}
    }
}
