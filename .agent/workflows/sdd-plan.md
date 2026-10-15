---
description: Gera automaticamente o plan.md e o tasks.md com tarefas atômicas para uma feature SDD, respeitando a constituição do projeto.
argument-hint: "[nome-da-feature]"
---

# SDD Plan Workflow (Geração de Plano Técnico e Tasks)

Este workflow automatiza o planejamento técnico e a decomposição de tarefas no método SDD (Specification Driven Development), unindo o papel de Arquiteto de Software do ECC com a metodologia de especificações do Macoratti.

## Uso

`/sdd-plan [nome-da-feature]`

Exemplo:
`/sdd-plan gestao-usuarios` ou `/sdd-plan specs/gestao-usuarios/spec.md`

## Procedimento

1. **Leitura e Contexto**:
   - Identificar a pasta da funcionalidade: `specs/[nome-da-feature]/`.
   - Ler obrigatoriamente o arquivo de especificação de negócio `specs/[nome-da-feature]/spec.md`.
   - Ler as regras arquiteturais globais em `.agent/rules/constitution.md` e `.agent/rules/csharp-coding.md`.
   - Se os moldes não existirem, utilize `specs/_template/plan.md` e `specs/_template/tasks.md` como base.

2. **Atuação como Arquiteto (Role: Architect)**:
   - Analisar os requisitos de negócio e restrições descritos no `spec.md`.
   - Definir os pacotes NuGet necessários, estrutura de pastas no `BaseSystem.Api` e `BaseSystem.Tests`.
   - Projetar a modelagem de entidades (EF Core Code-First), mapeamentos e DTOs (Records imutáveis).
   - Garantir que as diretrizes imutáveis sejam cumpridas:
     * Nunca injetar `DbContext` em Controllers/Endpoints (usar Services).
     * Toda operação assíncrona com `CancellationToken`.
     * Consultas de leitura com `.AsNoTracking()`.
     * Zero secrets/chaves expostas.

3. **Geração do `plan.md`**:
   - Criar ou sobrescrever `specs/[nome-da-feature]/plan.md` detalhando:
     - Visão de arquitetura e decisões técnicas.
     - Entidades, tabelas e mapeamentos EF Core.
     - Contratos de API (Request DTOs e Response DTOs como records).
     - Interfaces de serviços e injeção de dependência.
     - Estratégia de testes unitários com xUnit.

4. **Geração do `tasks.md`**:
   - Criar ou sobrescrever `specs/[nome-da-feature]/tasks.md` dividindo o trabalho em tarefas atômicas e sequenciais:
     - **T1**: Entidades e mapeamento EF Core.
     - **T2**: DTOs de Request/Response e validações.
     - **T3**: Testes unitários (TDD) para os cenários de negócio.
     - **T4**: Camada de serviço e lógica de negócio.
     - **T5**: Endpoints/Controllers HTTP e documentação Swagger.
   - Cada tarefa deve conter:
     - **Objetivo**: O que a tarefa entrega.
     - **Implementação**: Arquivos exatos a serem criados ou alterados.
     - **Critério de Validação**: Como verificar (ex: `dotnet build`, `dotnet test`).

5. **Apresentação e Confirmação**:
   - Exibir um resumo do plano gerado para o desenvolvedor.
   - Aguardar a revisão do usuário antes de iniciar qualquer implementação de código.
