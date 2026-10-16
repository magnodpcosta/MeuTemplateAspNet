---
description: Executa uma tarefa atômica por vez (T1..Tn) de uma feature SDD, com validação via dotnet build/test e aprovação antes de prosseguir.
argument-hint: "[nome-da-feature] [TaskID, ex: T1]"
---

# SDD Exec Workflow (Execução de Tasks com TDD e Validação)

Este workflow implementa passo a passo as tarefas planejadas para uma funcionalidade no padrão SDD, garantindo conformidade com a Constituição do Projeto e verificação contínua via compilação e testes.

## Uso

`/sdd-exec [nome-da-feature] [T1|T2|...|Tn]`

Exemplo:
`/sdd-exec gestao-usuarios T1`

## Procedimento

1. **Carga de Contexto**:
   - Ler os arquivos da feature:
     * `specs/[nome-da-feature]/spec.md` (Requisitos e Regras de Negócio)
     * `specs/[nome-da-feature]/plan.md` (Arquitetura e Decisões Técnicas)
     * `specs/[nome-da-feature]/tasks.md` (Definição detalhada da Task solicitada)
   - Ler e aplicar estritamente as regras de `.agent/rules/constitution.md` e `.agent/rules/csharp-coding.md`.

2. **Isolamento de Escopo (Uma Task por vez)**:
   - Implementar **exclusivamente** os arquivos e alterações definidos na tarefa informada (ex: se for `T1`, não implementar `T2` ou endpoints).
   - Seguir as regras imutáveis:
     * EF Core Code-First;
     * DbContext apenas em Serviços ou Repositórios (nunca em Controllers/Endpoints);
     * Records imutáveis para DTOs;
     * Operações de I/O e banco com `async/await` e `CancellationToken`;
     * Consultas de leitura com `.AsNoTracking()`;
     * Nenhuma credencial ou secret hardcoded.

3. **Validação Automática Obrigatória**:
   - Executar `dotnet build` na solution `BaseSystem.sln` para garantir **0 erros de compilação**.
   - Se a task envolver testes ou serviços (ex: T3 ou T4), executar `dotnet test` para validar que os testes estão passando.
   - Caso ocorra qualquer erro de compilação ou falha de teste, corrigir imediatamente antes de reportar.

4. **Atualização do Status**:
   - Atualizar o arquivo `specs/[nome-da-feature]/tasks.md`, marcando a tarefa concluída com `[x] Concluído`.

5. **Pausa para Aprovação**:
   - Informar detalhadamente o que foi implementado, quais arquivos foram criados/alterados e o resultado de `dotnet build` / `dotnet test`.
   - **NÃO avançar para a próxima tarefa automaticamente**. Aguardar a aprovação explícita do desenvolvedor para executar a próxima task.

