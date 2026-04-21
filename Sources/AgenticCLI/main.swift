import ArgumentParser

struct Agentic: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "agentic",
        abstract: "Agentic CLI: multi-provider coding assistant in Swift.",
        subcommands: [
            ChatCommand.self,
            RunCommand.self,
            AuthCommand.self,
            ModelCommand.self,
            SessionCommand.self,
            MCPCommand.self,
        ]
    )
}

Agentic.main()
