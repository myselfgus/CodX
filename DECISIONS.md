# DECISIONS — Registro de decisões arquiteturais

## 2026-04-21
### Decisão
Swift nativo como linguagem principal do CodX.
### Contexto
Necessidade de integração forte com ecossistema Apple, performance previsível e distribuição simples no alvo macOS.
### Consequência
Código principal permanece em Swift, evitando fragmentação de stack.

## 2026-04-21
### Decisão
Swift Package Manager (SwiftPM) como sistema de build e dependências.
### Contexto
Projeto já estruturado com `Package.swift`, com foco em simplicidade e padrão oficial Swift.
### Consequência
Build, testes e organização modular seguem convenções SwiftPM.

## 2026-04-21
### Decisão
Plataforma-alvo primária: macOS 26.
### Contexto
Escopo atual do produto prioriza ambiente Apple desktop moderno.
### Consequência
Recursos e integrações são planejados considerando APIs disponíveis nesta baseline.

## 2026-04-21
### Decisão
`codx` será distribuído como executável principal.
### Contexto
Fluxo principal de uso ocorre por linha de comando, com evolução para TUI.
### Consequência
A experiência CLI é tratada como caminho primário de operação.

## 2026-04-21
### Decisão
Keychain como mecanismo padrão para secrets.
### Contexto
Necessidade de armazenamento seguro de credenciais em ambiente macOS.
### Consequência
Segredos não devem ser persistidos em texto puro no banco/configuração.

## 2026-04-21
### Decisão
SQLite como camada de persistência local.
### Contexto
Requisito de armazenamento embutido, simples de distribuir e operar localmente.
### Consequência
Repos e schema devem ser desenhados para SQLite como backend primário.

## 2026-04-21
### Decisão
MCP oficial via stdio primeiro.
### Contexto
Necessidade de integração incremental e previsível com servidores MCP.
### Consequência
Fluxo inicial prioriza transporte stdio antes de protocolos adicionais.

## 2026-04-21
### Decisão
TUI ANSI própria (sem framework externo obrigatório).
### Contexto
Desejo de controle fino de renderização e redução de dependências.
### Consequência
Componentes de terminal e renderer são mantidos internamente.

## 2026-04-21
### Decisão
AppleFoundationProvider como provider local prioritário.
### Contexto
Prioridade para execução local e menor dependência de rede no caminho principal.
### Consequência
Fallbacks remotos são opcionais; fluxo base deve funcionar com provider local.

## 2026-04-21
### Decisão
SSH e iMessage fora do caminho crítico.
### Contexto
Escopo inicial foca núcleo de sessão, persistência, providers e experiência principal.
### Consequência
Integrações SSH/iMessage podem evoluir depois sem bloquear marcos essenciais.

## 2026-04-21
### Decisão
`AppKernel` passa a expor a configuração já resolvida, com bootstrap de configuração executado via `ConfigStore.bootstrap(defaults:)`; `Defaults` lê o config padrão embutido e `ConfigStore` se torna o único ponto de resolução da configuração efetiva (config local + fallback).
### Contexto
A T-003 exigiu fronteiras explícitas entre defaults embutidos, configuração local e composição do kernel, evitando duplicação de parsing e ambiguidade sobre onde a configuração efetiva é definida.
### Consequência
`ConfigStore` deixa de ser um store genérico de JSON e passa a ser especializado em `AppConfiguration`; `AppKernel.init` passa a ser `throws` por depender da resolução da configuração.

## 2026-04-21
### Decisão
O target de testes passa a depender explicitamente do pacote oficial `swift-testing`.
### Contexto
No ambiente atual com Command Line Tools, o módulo `Testing` não estava disponível implicitamente para `swift test`, impedindo a validação obrigatória do repositório mesmo com o código principal compilando normalmente.
### Consequência
Os testes ficam portáveis e executáveis de forma previsível no ambiente atual sem exigir instalação de Xcode completo nem alterar a camada de produção.
