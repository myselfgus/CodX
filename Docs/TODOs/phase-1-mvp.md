# Fase 1 — MVP utilizável

## TUI e UX
- [ ] Streaming no transcript
- [ ] Status bar fixa (provider/model/tokens/custo/tarefas/cwd)
- [ ] Seleção de provider/model em runtime
- [ ] Overlay de tarefas ativas

## Observabilidade
- [ ] swift-log + OSLog
- [ ] JSONL de auditoria
- [ ] Redação de dados sensíveis em logs

## Execução de tools
- [ ] Aprovação configurável para ações destrutivas
- [ ] Subprocessos paralelos não interativos
- [ ] Limite de paralelismo (núcleos/2, mínimo 2)

## Modelos e custos
- [ ] Cache TTL de modelos (1h)
- [ ] Persistência opcional do catálogo
- [ ] Token meter + estimador de custo

## MCP v1
- [ ] Cliente MCP via stdio
- [ ] Handshake no bootstrap
- [ ] Listagem de tools remotas
- [ ] Adapter MCP -> Tool local
