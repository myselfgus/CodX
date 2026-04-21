# Notas de implementação

## Regras de ouro

1. Core não depende de TUI.
2. Providers são adapters HTTP sobre `URLSession`.
3. Keychain é fonte primária de segredos.
4. SQLite é fonte de verdade para sessão/histórico/cache.
5. MCP começa com stdio no v1.

## Definition of Done (por item)

- Código compilando
- Testes mínimos passando
- Item marcado no TODO correspondente
- Commit com mensagem objetiva
