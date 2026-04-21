# CodX — AI Development Governance

## Missão do projeto
CodX é um agente de desenvolvimento em Swift para macOS, com foco em execução local, previsível e auditável. A missão é permitir evolução rápida do produto com assistência de IA, mantendo arquitetura clara, segurança de segredos, persistência confiável e experiência de uso consistente (CLI/TUI), sem comprometer qualidade ou estabilidade.

## Regras de trabalho da IA
1. Trabalhar sempre em passos pequenos e verificáveis.
2. Antes de codar, confirmar escopo, dependências e arquivos-alvo.
3. Não pular ordem de execução definida neste documento e em `TASKS.md`.
4. Não reescrever módulos estáveis sem necessidade explícita.
5. Priorizar compatibilidade com o scaffold atual do SwiftPM.
6. Toda mudança deve ser rastreável em commit, tarefa e decisão (quando aplicável).
7. Em caso de dúvida arquitetural, registrar em `DECISIONS.md` antes de expandir implementação.

## Sequência obrigatória de execução
1. Ler `AGENTS.md`, `TASKS.md`, `DECISIONS.md` e `docs/IMPLEMENTATION_ORDER.md`.
2. Selecionar a próxima tarefa desbloqueada em `TASKS.md`.
3. Validar dependências da tarefa e definição de pronto.
4. Implementar apenas o menor incremento necessário para concluir a tarefa.
5. Executar validações mínimas (`swift build` e `swift test`).
6. Atualizar `TASKS.md` (status/checklist) e `DECISIONS.md` (se houve decisão).
7. Gerar commit pequeno e descritivo.

## Limites por passo
A IA pode, em um único passo:
- Alterar arquivos de uma única tarefa, ou de subtarefa diretamente acoplada.
- Introduzir apenas interfaces/estruturas mínimas para destravar a próxima entrega.
- Refatorar pequeno trecho local quando necessário para manter compilação.

A IA não pode, em um único passo:
- Implementar múltiplas fases de `docs/IMPLEMENTATION_ORDER.md` de uma vez.
- Misturar mudanças de núcleo, persistência, providers e TUI sem necessidade real.
- Fazer mudança arquitetural ampla sem registrar decisão.
- Adicionar dependências externas, frameworks ou serviços sem aprovação explícita.

## Critérios de qualidade
- Compilação e testes verdes ao fim de cada mudança.
- Código legível, coeso e com nomes alinhados ao domínio.
- APIs pequenas, explícitas e previsíveis.
- Logs e trilhas de auditoria em pontos críticos.
- Sem duplicação desnecessária.
- Sem "TODO" aberto sem vínculo com tarefa em `TASKS.md`.

## Política de mudanças pequenas
- Um commit deve resolver um problema único e ter escopo claro.
- Preferir PRs incrementais e reversíveis.
- Evitar grandes renomeações ou reorganizações em lote.
- Se a mudança ultrapassar ~200 linhas, justificar no texto da tarefa e dividir se possível.

## Política de build e testes verdes
- `swift build` e `swift test` são obrigatórios em toda entrega.
- Se qualquer comando falhar, a tarefa não está pronta.
- Corrigir regressões antes de iniciar a próxima tarefa.

## Política de não inventar dependências nem APIs
- Não criar dependências de terceiros sem decisão registrada.
- Não inventar APIs que não sejam necessárias para a tarefa corrente.
- Toda API nova deve ter consumidor real no próprio incremento ou justificativa explícita.
- Reutilizar módulos existentes antes de criar novos.

## Política de registro de decisões
Registrar em `DECISIONS.md` sempre que houver:
- Escolha entre alternativas arquiteturais.
- Introdução/remoção de dependência.
- Mudança de contrato entre camadas.
- Decisão com impacto em segurança, persistência, providers ou UX principal.

Formato mínimo:
- Data
- Decisão
- Contexto
- Consequência

## Convenção de resources
- Resources usados por código Swift devem viver dentro do target correspondente (ex.: `Sources/Core/Resources/...`).
- Resources devem ser declarados no `Package.swift` quando forem efetivamente consumidos pelo build.
