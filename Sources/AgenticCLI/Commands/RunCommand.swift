import ArgumentParser

struct RunCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Run a single non-interactive prompt.")

    @Argument(help: "Prompt to execute.")
    var prompt: String

    mutating func run() async throws {
        print("TODO: execute prompt -> \(prompt)")
    }
}
