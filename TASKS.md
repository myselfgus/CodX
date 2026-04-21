# TASKS — Backlog inicial executável

> Status sugerido: `todo`, `doing`, `done`.

## T-001 — AppKernel base
- **Objetivo:** Definir inicialização central com composição mínima de componentes core.
- **Arquivos afetados:** `Sources/Core/AppKernel.swift`
- **Dependências:** nenhuma
- **Definição de pronto:** AppKernel constrói dependências core sem lógica implícita fora de sua responsabilidade; `swift build` e `swift test` verdes.
- **Status:** done

## T-002 — ConfigStore
- **Objetivo:** Estruturar leitura/escrita de configuração com contrato estável.
- **Arquivos afetados:** `Sources/Core/Config/ConfigStore.swift`
- **Dependências:** T-001
- **Definição de pronto:** ConfigStore expõe API clara para carregar e persistir config sem duplicação de parsing.
- **Status:** done

## T-003 — Defaults
- **Objetivo:** Consolidar valores padrão e fallback de configuração.
- **Arquivos afetados:** `Sources/Core/Config/Defaults.swift`, `Sources/Core/Resources/default-config.json`
- **Dependências:** T-002
- **Definição de pronto:** Defaults centralizados e alinhados ao config padrão do projeto.
- **Status:** done

## T-004 — Log
- **Objetivo:** Definir logging operacional básico para fluxos principais.
- **Arquivos afetados:** `Sources/Core/Logging/Log.swift`
- **Dependências:** T-001
- **Definição de pronto:** API de log consistente, sem acoplamento indevido com camadas externas.
- **Status:** todo

## T-005 — AuditLog
- **Objetivo:** Estruturar trilha de auditoria para eventos relevantes de sessão/ferramentas.
- **Arquivos afetados:** `Sources/Core/Logging/AuditLog.swift`
- **Dependências:** T-004
- **Definição de pronto:** Eventos de auditoria com formato previsível e pronto para persistência.
- **Status:** todo

## T-006 — SessionState
- **Objetivo:** Modelar estado de sessão com fronteiras claras de mutação.
- **Arquivos afetados:** `Sources/Core/Session/SessionState.swift`
- **Dependências:** T-001
- **Definição de pronto:** Estado tipado e serializável quando aplicável, sem efeitos colaterais ocultos.
- **Status:** todo

## T-007 — SessionManager
- **Objetivo:** Orquestrar ciclo de vida de sessão utilizando SessionState e logging.
- **Arquivos afetados:** `Sources/Core/Session/SessionManager.swift`
- **Dependências:** T-005, T-006
- **Definição de pronto:** Operações de iniciar/retomar/encerrar sessão com transições válidas e logadas.
- **Status:** todo

## T-008 — Database
- **Objetivo:** Definir camada de acesso SQLite com bootstrap previsível.
- **Arquivos afetados:** `Sources/Core/Persistence/Database.swift`
- **Dependências:** T-001
- **Definição de pronto:** Inicialização de banco e gerenciamento de conexão com erro tratável.
- **Status:** todo

## T-009 — SessionRepo
- **Objetivo:** Persistir e recuperar sessões via Database.
- **Arquivos afetados:** `Sources/Core/Persistence/SessionRepo.swift`
- **Dependências:** T-008, T-006
- **Definição de pronto:** CRUD mínimo de sessão funcional e coberto por testes.
- **Status:** todo

## T-010 — MessageRepo
- **Objetivo:** Persistir e consultar mensagens vinculadas às sessões.
- **Arquivos afetados:** `Sources/Core/Persistence/MessageRepo.swift`
- **Dependências:** T-008, T-009
- **Definição de pronto:** Inserção e listagem de mensagens por sessão com ordenação consistente.
- **Status:** todo

---

## Quebra da issue #3 em tarefas pequenas

### T-003.1 — Inventariar contratos atuais
- **Objetivo:** Mapear responsabilidades atuais dos módulos da issue #3.
- **Arquivos afetados:** `Sources/Core/AppKernel.swift`, `Sources/Core/Config/ConfigStore.swift`, `Sources/Core/Config/Defaults.swift`
- **Dependências:** T-001
- **Definição de pronto:** Lista objetiva de contratos e lacunas registrada na própria issue/tarefa.
- **Nota curta:** o inventário identificou a ausência de um tipo explícito de configuração e de um caminho único para resolver `default-config.json` + `config.json`, além de fronteiras ambíguas entre `Defaults`, `ConfigStore` e `AppKernel`.
- **Status:** done

### T-003.2 — Definir interfaces mínimas
- **Objetivo:** Padronizar protocolos/assinaturas mínimas para evolução incremental.
- **Arquivos afetados:** mesmos de T-003.1
- **Dependências:** T-003.1
- **Definição de pronto:** Interfaces estáveis sem implementação extra além do necessário.
- **Status:** done

### T-003.3 — Implementar bootstrap de configuração
- **Objetivo:** Garantir caminho único de carga de defaults + configuração local.
- **Arquivos afetados:** `Sources/Core/Config/ConfigStore.swift`, `Sources/Core/Config/Defaults.swift`, `Sources/Core/Resources/default-config.json`
- **Dependências:** T-003.2
- **Definição de pronto:** Bootstrap previsível com fallback explícito.
- **Status:** done

### T-003.4 — Integrar com AppKernel
- **Objetivo:** Conectar configuração no kernel sem vazamento de responsabilidade.
- **Arquivos afetados:** `Sources/Core/AppKernel.swift`
- **Dependências:** T-003.3
- **Definição de pronto:** Kernel sobe com ConfigStore/Defaults sem lógica duplicada.
- **Status:** done

### T-003.5 — Validar e estabilizar
- **Objetivo:** Assegurar regressão zero da issue #3.
- **Arquivos afetados:** `Tests/CoreTests/CoreTests.swift` (se necessário)
- **Dependências:** T-003.4
- **Definição de pronto:** `swift build` e `swift test` verdes; issue #3 com checklist concluído.
- **Status:** done
