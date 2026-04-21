import ArgumentParser

struct ModelCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "List and refresh available models.",
        subcommands: [List.self, Refresh.self]
    )
}

extension ModelCommand {
    struct List: AsyncParsableCommand {
        mutating func run() async throws { print("TODO: model list") }
    }

    struct Refresh: AsyncParsableCommand {
        @Option(name: .shortAndLong) var provider: String?
        mutating func run() async throws { print("TODO: model refresh \(provider ?? "all")") }
    }
}
