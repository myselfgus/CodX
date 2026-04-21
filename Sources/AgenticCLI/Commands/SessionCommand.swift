import ArgumentParser

struct SessionCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "List and resume sessions.",
        subcommands: [List.self, Resume.self]
    )
}

extension SessionCommand {
    struct List: AsyncParsableCommand {
        mutating func run() async throws { print("TODO: session list") }
    }

    struct Resume: AsyncParsableCommand {
        @Argument var id: String
        mutating func run() async throws { print("TODO: session resume \(id)") }
    }
}
