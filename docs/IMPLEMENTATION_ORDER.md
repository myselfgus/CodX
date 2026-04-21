# IMPLEMENTATION ORDER

## Fase 1 — Núcleo
- **Objetivo:** Consolidar o núcleo de inicialização e estado de sessão.
- **Arquivos-alvo:**
  - `Sources/Core/AppKernel.swift`
  - `Sources/Core/Config/ConfigStore.swift`
  - `Sources/Core/Config/Defaults.swift`
  - `Sources/Core/Session/SessionState.swift`
  - `Sources/Core/Session/SessionManager.swift`
  - `Sources/Core/Logging/Log.swift`
  - `Sources/Core/Logging/AuditLog.swift`
- **Critérios de aceite:** Kernel sobe dependências essenciais; sessão e logging têm contratos estáveis.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 2 — Persistência
- **Objetivo:** Estruturar armazenamento local de sessões e mensagens.
- **Arquivos-alvo:**
  - `Sources/Core/Persistence/Database.swift`
  - `Sources/Core/Persistence/SessionRepo.swift`
  - `Sources/Core/Persistence/MessageRepo.swift`
- **Critérios de aceite:** Repositórios operam sobre SQLite com operações mínimas previsíveis.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 3 — Secrets
- **Objetivo:** Garantir gestão segura de credenciais e tokens.
- **Arquivos-alvo:**
  - `Sources/Core/Security/KeychainService.swift`
  - `Sources/Core/Security/SecretResolver.swift`
- **Critérios de aceite:** Segredos resolvidos via Keychain sem persistência insegura.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 4 — Providers
- **Objetivo:** Padronizar integração com providers priorizando local-first.
- **Arquivos-alvo:**
  - `Sources/Core/Providers/LLMProvider.swift`
  - `Sources/Core/Providers/ProviderRegistry.swift`
  - `Sources/Core/Providers/AppleFoundationProvider.swift`
  - `Sources/Core/Providers/OpenAIProvider.swift`
  - `Sources/Core/Providers/AnthropicProvider.swift`
  - `Sources/Core/Providers/OllamaProvider.swift`
  - `Sources/Core/Providers/XAIProvider.swift`
- **Critérios de aceite:** Registro de providers estável, provider local priorizado por padrão.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 5 — CLI útil
- **Objetivo:** Entregar fluxos CLI operacionais para uso diário.
- **Arquivos-alvo:**
  - `Sources/AgenticCLI/main.swift`
  - `Sources/AgenticCLI/Commands/ChatCommand.swift`
  - `Sources/AgenticCLI/Commands/SessionCommand.swift`
  - `Sources/AgenticCLI/Commands/ModelCommand.swift`
  - `Sources/AgenticCLI/Commands/AuthCommand.swift`
  - `Sources/AgenticCLI/Commands/RunCommand.swift`
- **Critérios de aceite:** Comandos principais executáveis e alinhados ao kernel/sessão.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 6 — Subprocessos/Tools
- **Objetivo:** Consolidar execução de comandos e ferramentas locais com rastreabilidade.
- **Arquivos-alvo:**
  - `Sources/Core/Subprocess/ProcessExecutor.swift`
  - `Sources/Core/Subprocess/PTYExecutor.swift`
  - `Sources/Core/Subprocess/ProcessEvent.swift`
  - `Sources/Core/Tools/Tool.swift`
  - `Sources/Core/Tools/ToolRegistry.swift`
  - `Sources/Core/Tools/CommandTool.swift`
  - `Sources/Core/Tools/ParallelCommandTool.swift`
  - `Sources/Core/Tools/FileSystemTool.swift`
  - `Sources/Core/Tools/EditFileTool.swift`
- **Critérios de aceite:** Execução de tools com isolamento básico, telemetria e logs coerentes.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 7 — TUI
- **Objetivo:** Evoluir interface terminal para operação interativa robusta.
- **Arquivos-alvo:**
  - `Sources/TUI/TerminalApp.swift`
  - `Sources/TUI/Renderer.swift`
  - `Sources/TUI/ScreenState.swift`
  - `Sources/TUI/InputLoop.swift`
  - `Sources/TUI/ANSI/ANSI.swift`
  - `Sources/TUI/ANSI/DiffRenderer.swift`
  - `Sources/TUI/Components/TranscriptView.swift`
  - `Sources/TUI/Components/InputView.swift`
  - `Sources/TUI/Components/StatusBar.swift`
  - `Sources/TUI/Components/TaskOverlay.swift`
- **Critérios de aceite:** Fluxo de interação principal funcional, renderização estável e legível.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 8 — MCP
- **Objetivo:** Integrar protocolo MCP oficial com prioridade para stdio.
- **Arquivos-alvo:**
  - `Sources/Core/MCP/MCPManager.swift`
  - `Sources/Core/MCP/MCPProcessHost.swift`
  - `Sources/Core/MCP/MCPToolAdapter.swift`
  - `Sources/AgenticCLI/Commands/MCPCommand.swift`
  - `Resources/mcp-servers.example.json`
- **Critérios de aceite:** Servidores MCP registráveis e consumíveis no fluxo principal via stdio.
- **Comandos de validação:**
  - `swift build`
  - `swift test`

## Fase 9 — Polimento
- **Objetivo:** Fechar gaps de qualidade, DX e documentação final.
- **Arquivos-alvo:**
  - `README.md`
  - `Docs/TODOs/*`
  - arquivos de testes e documentação relacionados
- **Critérios de aceite:** Documentação coerente com comportamento atual e backlog atualizado.
- **Comandos de validação:**
  - `swift build`
  - `swift test`
