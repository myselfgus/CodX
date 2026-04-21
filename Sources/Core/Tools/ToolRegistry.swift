public actor ToolRegistry {
    private var tools: [String: any Tool] = [:]

    public init() {}

    public func register(_ tool: any Tool) {
        tools[tool.name] = tool
    }

    public func tool(named name: String) -> (any Tool)? {
        tools[name]
    }
}
