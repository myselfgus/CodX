import ArgumentParser

struct CodXCLI: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "codx",
        abstract: "CodX command line interface.",
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

CodXCLI.main()
