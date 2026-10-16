# 🚀 Meu Template Padrão ASP.NET Core (SDD + Antigravity + ECC)

> **Template de Arquitetura Limpa para .NET 10 / C#** integrado à metodologia **SDD (Spec-Driven Development)** do Macoratti e ao ecossistema de agentes especialistas **ECC (Enterprise Coding Config)** no Google Antigravity.

---

## 📌 Sumário
1. [Visão Geral: O que é este template?](#-visão-geral-o-que-é-este-template)
2. [Entendendo a Diferença: SDD vs. ECC](#-entendendo-a-diferença-sdd-vs-ecc)
3. [Como criar um projeto do zero a partir deste Template](#-como-criar-um-projeto-do-zero-a-partir-deste-template)
4. [Como adicionar novas funcionalidades (O Guia Definitivo do SDD)](#-como-adicionar-novas-funcionalidades-o-guia-definitivo-do-sdd)
   - [Exemplo Real: Sistema de Acompanhamento de Processos Administrativos](#exemplo-real-sistema-de-acompanhamento-de-processos-administrativos)
   - [Eu preciso fazer as classes na mão?](#eu-preciso-fazer-as-classes-na-mão)
5. [Passo a Passo: O Ciclo de Desenvolvimento de uma Feature](#-passo-a-passo-o-ciclo-de-desenvolvimento-de-uma-feature)
6. [Catálogo de Componentes (.agent)](#-catálogo-de-componentes-agent)
   - [Regras Globais (Rules)](#1-regras-globais-rules)
   - [Workflows (Comandos /)](#2-workflows-comandos-)
   - [Agentes Especialistas (Agents)](#3-agentes-especialistas-agents)
   - [Habilidades (Skills)](#4-habilidades-skills)
7. [Guia de Bolso: Quando chamar cada comando?](#-guia-de-bolso-quando-chamar-cada-comando)
8. [Estrutura de Pastas do Repositório](#-estrutura-de-pastas-do-repositório)
9. [Como aplicar em projetos existentes (Brownfield)](#-como-aplicar-em-projetos-existentes-brownfield)

---

## 💡 Visão Geral: O que é este template?

Quando desenvolvemos com Inteligência Artificial, o maior erro é pedir tudo de uma vez (*"crie um sistema completo de processos administrativos"*). Isso gera código raso, alucinações, classes desconexas e centenas de erros de compilação.

Este template resolve isso unindo duas forças:
1. **SDD (Spec-Driven Development)**: Metodologia onde cada funcionalidade nasce de uma especificação clara (**O Quê**), passa por um plano técnico (**O Como**) e é dividida em tarefas curtas (**Passo a Passo**).
2. **ECC + Antigravity**: Regras de arquitetura C# inegociáveis, agentes especialistas (Arquiteto, TDD Guide, Revisor de Segurança) e validação obrigatória com `dotnet build` a cada passo.

---

## ⚖️ Entendendo a Diferença: SDD vs. ECC

Eles **não são a mesma coisa**, mas trabalham juntos:

- **SDD é o PROCESSO (A Planta e o Cronograma da Obra)**:
  - Focado nas regras de negócio e na divisão de tarefas (`spec.md` ➔ `plan.md` ➔ `tasks.md`).
  - Diz à IA **o que** fazer e em **qual ordem**.
- **ECC é a EQUIPE TÉCNICA (O Arquiteto, o Engenheiro e o Fiscal da Obra)**:
  - Focado na excelência técnica, código C# limpo e segurança.
  - Fornece as personas de IA (`architect`, `tdd-guide`, `security-reviewer`) e as regras da empresa (`constitution.md`, OWASP Top 10, async/await).

---

## 🏗️ Como criar um projeto do zero a partir deste Template

### Opção A: Pelo GitHub (Recomendado)
1. No repositório deste template no GitHub, clique no botão verde **"Use this template"** ➔ **"Create a new repository"**.
2. Dê o nome do seu novo sistema (ex: `GestaoProcessosAdmin`).
3. Clone o novo repositório na sua máquina:
   ```bash
   git clone https://github.com/SEU_USUARIO/GestaoProcessosAdmin.git
   ```
4. Abra a pasta no **Antigravity**. Todas as regras, agentes e workflows já estarão ativos!

### Opção B: Copiando Localmente
1. Copie a pasta `MeuTemplateAspNet` para uma nova pasta (ex: `d:\Dev\GestaoProcessosAdmin`).
2. Se desejar renomear os projetos ou a solution de `BaseSystem` para o seu nome, use os comandos do `dotnet`:
   ```bash
   dotnet new sln -n GestaoProcessosAdmin
   ```

---

## 🧭 Como adicionar novas funcionalidades (O Guia Definitivo do SDD)

### Dúvida Comum: *"Eu preciso criar uma nova spec para cada feature?"*
**SIM! Exatamente essa é a mágica do SDD.**

Em vez de tentar construir o sistema todo em um único prompt gigante, você fatia o seu sistema em **pequenas entregas verticais e funcionais**.

### Exemplo Real: Sistema de Acompanhamento de Processos Administrativos
Se você vai construir esse sistema, você cria uma pasta em `specs/` para cada entrega de valor:

```plaintext
specs/
├── _template/                      <-- Molde original (nunca altere este)
├── 01-autenticacao-usuarios/       <-- Feature 1: Login, JWT, Perfis
├── 02-cadastro-processos/          <-- Feature 2: Abertura do processo e interessado
├── 03-tramitacao-etapas/           <-- Feature 3: Mover processo entre setores e pareceres
└── 04-anexos-documentos/           <-- Feature 4: Upload e consulta de PDFs
```

### Eu preciso fazer as classes na mão?
**NÃO! Você não precisa escrever código C# na mão.**
Você só precisa descrever a **regra de negócio** no arquivo `spec.md` em português claro. O Antigravity, usando os workflows deste template, vai:
1. Criar as Entidades e Mapeamentos do EF Core;
2. Criar os Records de DTOs;
3. Criar os Testes Unitários;
4. Implementar a Camada de Serviço com `async/await` e `CancellationToken`;
5. Criar os Endpoints da API;
6. Rodar `dotnet build` para provar que funciona com 0 erros.

---

## 🔄 Passo a Passo: O Ciclo de Desenvolvimento de uma Feature

Siga este roteiro para cada nova funcionalidade do seu sistema:

### 1. Criar a pasta da feature a partir do molde
Duplique a pasta `specs/_template` para a sua nova funcionalidade:
```powershell
Copy-Item -Recurse specs/_template specs/01-cadastro-processos
```

### 2. Preencher APENAS o `spec.md`
Abra `specs/01-cadastro-processos/spec.md` e preencha:
- **Objetivo de Negócio**: "Permitir que servidores registrem um novo processo administrativo com número único, assunto e interessado."
- **Regras de Negócio**: "O número do processo deve ter o formato AAAA/NNNNNN. O interessado deve ter CPF ou CNPJ válido."
- **Critérios de Aceite**: Cenários de sucesso (retorna 201 Created) e de erro (dados inválidos retornam 400 Bad Request).

> 💡 **Nota**: Não toque no `plan.md` nem no `tasks.md`! A IA vai preenchê-los para você na etapa seguinte.

### 3. Gerar o Plano e as Tasks com o Arquiteto
No chat do Antigravity, digite:
```text
/sdd-plan 01-cadastro-processos
```
*O que o Antigravity faz:* O agente Arquiteto do ECC lê a sua `spec.md`, consulta as regras em `.agent/rules/constitution.md` e preenche automaticamente o `plan.md` (com a arquitetura C#) e o `tasks.md` (dividido em `T1`, `T2`, `T3`, `T4`, `T5`).

### 4. Executar uma Task por vez (com validação estrita)
No chat do Antigravity, mande executar a primeira tarefa:
```text
/sdd-exec 01-cadastro-processos T1
```
*O que o Antigravity faz:*
- Implementa **apenas** a tarefa T1 (ex: Entidades e DbContext);
- Executa `dotnet build` e garante **0 erros de compilação**;
- Para e aguarda seu ok.

Você confere o resultado e pede a próxima:
```text
/sdd-exec 01-cadastro-processos T2
```
(E assim por diante para `T3`, `T4` e `T5` até finalizar a feature).

### 5. Blindar com Auditoria de Segurança e Qualidade
Antes de subir para o GitHub ou abrir Pull Request:
```text
/security-review
```
O ECC simula a visão de um invasor e procura brechas de OWASP Top 10, vazamentos de dados ou chaves hardcoded.

```text
/code-review
```
O ECC revisa a legibilidade, padrões C# e performance do código implementado.

---

## 📦 Catálogo de Componentes (.agent)

Toda a inteligência do projeto está organizada na pasta `.agent/`:

### 1. Regras Globais (`.agent/rules/`)
Arquivos lidos automaticamente em **todas** as conversas:
- **`constitution.md`**: A Bíblia do seu sistema. Exige EF Core Code-First, proíbe `DbContext` direto na Controller, exige DTOs imutáveis (`records`), `async/await` com `CancellationToken`, `.AsNoTracking()` em leituras, zero secrets no código e compilação limpa com 0 erros.
- **`csharp-coding.md` / `csharp-coding-style.md`**: Padrões modernos do C# 12/13/14, nullable reference types e imutabilidade.
- **`csharp-security.md`**: Proteções específicas para ASP.NET Core e injeção de dependência.
- **`common-*.md`**: Regras de Git, performance e boas práticas herdadas do ECC.

### 2. Workflows (Comandos `/`)
Comandos acionáveis diretamente no chat para automatizar etapas complexas:

| Comando | Workflow | Para que serve? | Quando usar? |
| :--- | :--- | :--- | :--- |
| **`/sdd-plan`** | `sdd-plan.md` | Lê o `spec.md` e gera `plan.md` e `tasks.md` | Ao iniciar uma nova feature após preencher o `spec.md`. |
| **`/sdd-exec`** | `sdd-exec.md` | Implementa uma task atômica (ex: `T1`) e valida com `dotnet build` | Para codificar cada tarefa de forma controlada. |
| **`/plan`** | `plan.md` | Planejador geral de arquitetura do ECC | Para grandes refatorações ou mudanças estruturais no projeto. |
| **`/tdd`** | `tdd.md` | Ciclo RED ➔ GREEN ➔ REFACTOR com cobertura 80%+ | Ao implementar uma regra ou serviço usando TDD estrito. |
| **`/security-review`** | `security-review.md` | Auditoria OWASP Top 10 e AgentShield ("Modo Invasor") | Antes de finalizar qualquer funcionalidade ou antes de PRs. |
| **`/code-review`** | `code-review.md` | Análise 360° (Qualidade, Performance e Segurança) | Antes de realizar commits importantes. |
| **`/test-coverage`** | `test-coverage.md` | Analisa cobertura e gera testes unitários faltantes | Para garantir que a suíte de testes atinja 80%+. |

### 3. Agentes Especialistas (`.agent/agents/`)

O repositório original do ECC traz mais de **71 agentes** de dezenas de linguagens e nichos (PHP, Swift, Ruby, Rust, Python/Django, marketing, redes, etc.). Em um projeto .NET, manter dezenas de agentes não relacionados consome contexto de tokens e polui o ambiente.

Por isso, este template inclui o script de curadoria automatizada **`scripts/curate-agents.ps1`**, que manteve **apenas os 23 especialistas de alto impacto** para a stack C# / ASP.NET Core e Engenharia de Software.

#### 🤖 Tabela Completa dos 23 Agentes Especialistas Ativos

| Agente | Arquivo | Especialidade / O que faz | Quando e Como Chamar |
| :--- | :--- | :--- | :--- |
| **Architect** | `architect.md` | Desenho de arquitetura de alto nível, escalabilidade e decisões de design. | Chame no início de novas funcionalidades ou grandes refatorações (`/sdd-plan` ou no prompt: *"Como Arquiteto, avalie..."*). |
| **Code Architect** | `code-architect.md` | Cria blueprints concretos de implementação (arquivos, interfaces e ordem de build). | Ao transformar requisitos complexos em planos técnicos detalhados. |
| **Planner** | `planner.md` | Decompõe tarefas complexas e mapeia riscos e dependências. | Acionado automaticamente pelo `/plan` ou no prompt. |
| **Code Explorer** | `code-explorer.md` | Rastreia caminhos de execução, mapeia camadas e dependências em código existente. | Ao entrar em uma funcionalidade legada desconhecida para entender o fluxo antes de alterar. |
| **C# Reviewer** | `csharp-reviewer.md` | Especialista em C#, .NET 8/9/10, async/await, LINQ, nullable types e EF Core. | Acionado pelo `/code-review` ou após criar/alterar qualquer arquivo `.cs`. |
| **F# Reviewer** | `fsharp-reviewer.md` | Revisor de código funcional F# para cálculo, types e pattern matching. | Quando houver módulos ou bibliotecas em F# no ecossistema .NET. |
| **Database Reviewer** | `database-reviewer.md` | Otimização de SQL, migrations do EF Core, índices e performance de banco. | Ao criar ou alterar tabelas, migrations ou queries complexas no EF Core. |
| **TDD Guide** | `tdd-guide.md` | Especialista no ciclo estrito Red-Green-Refactor com meta de 80%+ de cobertura. | Acionado pelo `/tdd` ou `/sdd-exec` ao implementar regras de negócio. |
| **PR Test Analyzer** | `pr-test-analyzer.md` | Analisa a completude e qualidade comportamental da suíte de testes. | Antes de abrir um Pull Request ou após criar novos testes com xUnit. |
| **E2E Runner** | `e2e-runner.md` | Gera e executa testes de ponta a ponta (E2E) com Playwright. | Para testar fluxos completos da API ou UI em integração contínua. |
| **Agent Evaluator** | `agent-evaluator.md` | Avalia respostas e planos segundo critérios de precisão, clareza e completude. | Para auditar a qualidade técnica das propostas geradas pela IA. |
| **Security Reviewer** | `security-reviewer.md` | Auditoria OWASP Top 10, proteção de dados, JWT, secrets e injeção de SQL. | Acionado pelo `/security-review` antes de qualquer entrega ou deploy. |
| **Build Error Resolver** | `build-error-resolver.md` | Diagnóstico e correção cirúrgica de falhas de compilação no `dotnet build`. | Acionado automaticamente quando ocorrem erros de compilação ou dependências NuGet. |
| **Silent Failure Hunter** | `silent-failure-hunter.md` | Caça `try/catch` vazios, erros engolidos e exceções não propagadas. | Em revisões de resiliência e tratamento de erros na camada de serviço. |
| **Spec Miner** | `spec-miner.md` | Extrai regras de negócio de código legado existente e gera specs SDD. | **Fundamental em Brownfield**: use para documentar uma funcionalidade antiga antes de refatorá-la! |
| **Refactor Cleaner** | `refactor-cleaner.md` | Identifica e remove código morto, classes não utilizadas e duplicações. | Em manutenções periódicas de limpeza técnica e redução de dívida técnica. |
| **Code Simplifier** | `code-simplifier.md` | Refatora código complexo tornando-o limpo e direto, preservando 100% do comportamento. | Após fazer o código funcionar, para polir legibilidade e manutenibilidade. |
| **Code Reviewer** | `code-reviewer.md` | Revisão 360° em qualidade, legibilidade, SOLID e Clean Architecture. | Acionado pelo `/code-review` antes de comitar. |
| **Type Design Analyzer** | `type-design-analyzer.md` | Analisa imutabilidade, records, encapsulation e invariantes de domínio. | Ao desenhar entidades, DTOs e Value Objects em DDD. |
| **Performance Optimizer** | `performance-optimizer.md` | Identifica gargalos de CPU/memória, consultas lentas e uso de `.AsNoTracking()`. | Quando endpoints ou consultas ao banco apresentarem lentidão. |
| **Commit Reviewer** | `commit-reviewer.md` | Avalia o diff e gera mensagens de commit seguindo Conventional Commits. | Antes de rodar `git commit` para padronizar o histórico do Git. |
| **Doc Updater** | `doc-updater.md` | Mantém READMEs, diagramas e codemaps sincronizados com o código. | Ao concluir uma funcionalidade para atualizar documentação viva. |
| **Docs Lookup** | `docs-lookup.md` | Consulta documentações oficiais e exemplos atualizados de bibliotecas via Context7 MCP. | Quando tiver dúvidas sobre sintaxe ou APIs de pacotes NuGet novos. |

---

### ⚙️ Como Automatizar a Escolha de Agentes com o `curate-agents.ps1`

Nem todo projeto precisa de todos os agentes. Para automatizar a filtragem e garantir que seu projeto (novo ou existente) tenha apenas o necessário:

```powershell
# Opção 1: Perfil C# / .NET Padrão (Mantém os 23 agentes essenciais listados acima)
.\scripts\curate-agents.ps1 -Profile dotnet

# Opção 2: Perfil Fullstack (Mantém .NET + TypeScript, React, Vue e A11y para projetos com front-end)
.\scripts\curate-agents.ps1 -Profile dotnet-fullstack

# Opção 3: Perfil Mínimo (Mantém apenas o Top 10 crítico: Arquiteto, C#, TDD, Security, etc.)
.\scripts\curate-agents.ps1 -Profile minimal

# Opção 4: Simulação segura (não deleta nada, apenas mostra o que seria mantido/removido)
.\scripts\curate-agents.ps1 -Profile dotnet -DryRun
```

> 💡 **Para aplicar em um projeto existente (como `D:\Dev\Gestao_Frotas`):**
> ```powershell
> .\scripts\curate-agents.ps1 -Profile dotnet -TargetPath "D:\Dev\Gestao_Frotas"
> ```


### 4. Habilidades (`.agent/skills/`)
Módulos de conhecimento estendido que o agente consulta conforme a necessidade:
- **`tdd-workflow`**: Guia completo de estratégias de testes unitários, integração e mocks.
- **`architecture-decision-records`**: Como documentar ADRs para decisões de design.
- **`verification-loop`**: Procedimento de verificação contínua e correção de erros de build.

---

## 🎯 Guia de Bolso: Quando chamar cada comando?

| Quero... | O que devo fazer / chamar? |
| :--- | :--- |
| **Começar uma funcionalidade nova** | Crie a pasta em `specs/minha-feature/`, edite o `spec.md` e rode `/sdd-plan minha-feature` |
| **Implementar uma tarefa do plano** | Rode `/sdd-exec minha-feature T1` (depois `T2`, `T3`...) |
| **Criar uma classe ou método complexo com testes** | Chame `/tdd "implementar cálculo de prazos no ProcessoService"` |
| **Garantir que a API está segura contra invasões** | Rode `/security-review` |
| **Revisar o código antes de subir para o Git** | Rode `/code-review` |
| **Aumentar a cobertura de testes do projeto** | Rode `/test-coverage` |

---

## 📂 Estrutura de Pastas do Repositório

```plaintext
MeuTemplateAspNet/
├── .agent/                          <-- Inteligência do Antigravity + ECC
│   ├── agents/                      <-- Personas especializadas (Architect, TDD Guide, etc.)
│   ├── rules/                       <-- Regras imutáveis (.NET, C#, constitution.md)
│   ├── skills/                      <-- Habilidades sob demanda (TDD, ADRs, etc.)
│   └── workflows/                   <-- Comandos de barra (/sdd-plan, /sdd-exec, /security-review...)
├── specs/                           <-- Governança SDD de funcionalidades
│   └── _template/                   <-- Molde para novas features
│       ├── spec.md                  <-- O Quê (Negócio e Regras)
│       ├── plan.md                  <-- O Como (Arquitetura Técnica)
│       └── tasks.md                 <-- Passo a Passo (Tarefas T1..Tn)
├── BaseSystem.Api/                  <-- Web API ASP.NET Core (.NET 10)
│   ├── Controllers/ (ou Endpoints)
│   ├── Data/
│   ├── Models/
│   └── Services/
├── BaseSystem.Tests/                <-- Testes Unitários e de Integração (xUnit)
├── BaseSystem.sln                   <-- Solution .NET vinculando os projetos
├── .gitignore                       <-- Padrão .NET (ignora bin/, obj/, etc.)
└── README.md                        <-- Este manual de operação
```

---

## 🔄 Como aplicar em projetos existentes (Brownfield)

Você já possui um sistema em andamento (como o `D:\Dev\Gestao_Frotas`) e quer aplicar essa metodologia sem quebrar o que já funciona em produção?

Consulte nosso guia completo passo a passo:
👉 **[COMO_USAR_EM_PROJETOS_EXISTENTES.md](COMO_USAR_EM_PROJETOS_EXISTENTES.md)**

Aprenda como aplicar o **Padrão Estrangulador (Strangler Fig Pattern)**, injetar a pasta `.agent/` e `specs/`, rodar diagnósticos com `/security-review`, escrever testes de caracterização com `/tdd` e refatorar módulos legados de forma cirúrgica e segura!

---

## 🌟 Princípio Fundamental

> **"Nunca peça para a IA codificar antes de planejar; nunca aceite um código sem compilar com 0 erros; nunca suba para produção sem auditoria de segurança."**

