import ArgumentParser

struct ChatCommand: AsyncParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Start interactive chat mode.")

    mutating func run() async throws {}
}
