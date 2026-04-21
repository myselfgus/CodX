public actor ProviderRegistry {
    private var providers: [String: any LLMProvider] = [:]

    public init() {}

    public func register(_ provider: any LLMProvider) {
        providers[provider.id] = provider
    }

    public func provider(id: String) -> (any LLMProvider)? {
        providers[id]
    }
}
