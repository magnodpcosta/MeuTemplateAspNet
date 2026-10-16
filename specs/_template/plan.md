# Plano Técnico: [Nome da Funcionalidade]

## 1. Decisões Técnicas e Arquitetura
- **Padrão Arquitetural**: Controller / Endpoint -> Service / Repository -> EF Core DbContext.
- **Pacotes NuGet Necessários**:
  - [Ex: Microsoft.EntityFrameworkCore, FluentValidation, etc.]
- **Estrutura de Pastas e Arquivos Previstos**:
  - `BaseSystem.Api/Models/Entities/` -> Entidades de Domínio
  - `BaseSystem.Api/Models/Dtos/` -> Records de Request e Response
  - `BaseSystem.Api/Data/` -> Mapeamentos e DbContext
  - `BaseSystem.Api/Services/` -> Interfaces e Implementações dos Serviços
  - `BaseSystem.Api/Controllers/` -> Controllers ou Minimal API Endpoints
  - `BaseSystem.Tests/Services/` -> Testes Unitários com xUnit

## 2. Modelagem de Dados e Entidades
- **Entidade(s)**:
  - Nome: `[NomeDaEntidade]`
  - Propriedades e tipos primitivos/complexos
- **Mapeamento EF Core**:
  - Nome da Tabela, Chaves Primárias, Chaves Estrangeiras, Índices e Constraints

## 3. Contratos de API (DTOs)
- **Request DTOs**:
  - `[Nome]Request` (record imutável)
- **Response DTOs**:
  - `[Nome]Response` (record imutável)

## 4. Interfaces e Serviços
- `I[Nome]Service`
  - Métodos assíncronos recebendo `CancellationToken`
  - Uso de `.AsNoTracking()` em métodos de consulta

## 5. Estratégia de Testes
- Testes unitários cobrindo as regras de negócio do serviço.
- Validação de casos de sucesso e cenários de erro/exceção.

