import ArgumentParser

struct ChatCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Start interactive chat (TUI).")

    mutating func run() async throws {
        print("TODO: launch TUI interactive mode")
    }
}
