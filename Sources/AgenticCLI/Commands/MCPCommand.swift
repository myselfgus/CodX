import ArgumentParser

struct MCPCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Manage MCP servers and connectivity.",
        subcommands: [List.self, Add.self, Test.self]
    )
}

extension MCPCommand {
    struct List: AsyncParsableCommand {
        mutating func run() async throws { print("TODO: mcp list") }
    }

    struct Add: AsyncParsableCommand {
        mutating func run() async throws { print("TODO: mcp add") }
    }

    struct Test: AsyncParsableCommand {
        @Argument var name: String
        mutating func run() async throws { print("TODO: mcp test \(name)") }
    }
}
