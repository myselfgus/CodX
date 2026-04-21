# Fase 0 — Base compilável

## Scaffold e arquitetura
- [ ] Validar layout de diretórios (CLI/Core/TUI desacoplados)
- [ ] Configurar `AppKernel` e composição de dependências
- [ ] Definir contratos estáveis (`LLMProvider`, `Tool`, `SessionStore`)

## CLI mínima
- [ ] `agentic run`
- [ ] `agentic chat`
- [ ] `agentic auth add/remove/list`
- [ ] `agentic model list/refresh`
- [ ] `agentic session list/resume`
- [ ] `agentic mcp list/add/test`

## Providers iniciais
- [ ] OpenAI (list + stream + tools)
- [ ] Anthropic (list + stream + tools)
- [ ] xAI/Grok (list + stream + tools)
- [ ] Ollama (tags + chat)
- [ ] Apple Foundation Models (sessões + streaming + tool calling)

## Segurança e persistência
- [ ] KeychainService (Security.framework direto)
- [ ] Resolver segredos com precedência Keychain > ENV > config
- [ ] SQLite + migrações iniciais
- [ ] Tabelas: sessions/messages/tool_invocations/model_cache/preferences

## Tools locais
- [ ] read_file
- [ ] write_file
- [ ] list_directory
- [ ] run_command
- [ ] Política de roots autorizadas + timeout
