import ArgumentParser

struct SessionCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "List and resume sessions.",
        subcommands: [List.self, Resume.self]
    )
}

extension SessionCommand {
    struct List: AsyncParsableCommand {
        mutating func run() async throws {}
    }

    struct Resume: AsyncParsableCommand {
        @Argument var id: String
        mutating func run() async throws {}
    }
}
