---
description: Implementa funções e funcionalidades seguindo o ciclo TDD (Red-Green-Refactor) com garantia de 80%+ de cobertura de testes.
agent: tdd-guide
argument-hint: "[descrição da função/feature ou caminho para *.plan.md]"
---

# TDD Workflow Command

Ativa o especialista TDD (`tdd-guide`) para implementar o código através do ciclo estrito RED -> GREEN -> REFACTOR.

## Uso

`/tdd [descrição da funcionalidade ou caminho do plano]`

Exemplo:
`/tdd Implementar validação e cálculo de desconto no PedidoService`

## O que este workflow faz:

1. **RED (Teste Primeiro)**: Escreve o teste unitário/integração no `BaseSystem.Tests/` descrevendo o comportamento esperado e executa `dotnet test` para comprovar a falha.
2. **GREEN (Código Mínimo)**: Implementa o código mínimo necessário em `BaseSystem.Api/` para fazer o teste passar. Executa `dotnet test` para comprovar que passou.
3. **REFACTOR (Melhoria)**: Refatora o código eliminando duplicações e otimizando a legibilidade sem quebrar os testes.
4. **Verificação de Cobertura**: Garante cobertura mínima de 80% nos cenários críticos, fluxos de exceção e limites de borda.

