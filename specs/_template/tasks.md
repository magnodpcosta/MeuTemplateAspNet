# Lista de Tarefas (SDD Tasks): [Nome da Funcionalidade]

> **Regra de Ouro**: Cada tarefa é atômica e deve compilar com `dotnet build` com 0 erros e passar nos testes (`dotnet test`) antes de avançar para a próxima.

---

### T1: Modelagem de Domínio e Configuração EF Core
- **Objetivo**: Criar a entidade de domínio e seu mapeamento no Entity Framework Core.
- **Implementação**:
  - Criar a entidade em `BaseSystem.Api/Models/Entities/`.
  - Configurar mapeamento via `EntityTypeConfiguration` ou registro no `DbContext`.
- **Critério de Validação**:
  - `dotnet build` executa com 0 erros.

---

### T2: DTOs e Contratos da Funcionalidade
- **Objetivo**: Definir os contratos de entrada e saída (Records imutáveis).
- **Implementação**:
  - Criar Request DTOs e Response DTOs em `BaseSystem.Api/Models/Dtos/`.
  - Incluir regras de validação necessárias.
- **Critério de Validação**:
  - `dotnet build` executa com 0 erros.

---

### T3: Testes Unitários da Camada de Serviço (TDD)
- **Objetivo**: Definir os testes da lógica de negócio antes ou junto com a implementação do serviço.
- **Implementação**:
  - Criar classe de teste em `BaseSystem.Tests/`.
  - Cobrir cenários de sucesso e fluxos de erro/validação.
- **Critério de Validação**:
  - `dotnet test` compilando e executando.

---

### T4: Camada de Serviço e Lógica de Negócio
- **Objetivo**: Implementar a lógica de negócio, respeitando assincronismo e `.AsNoTracking()`.
- **Implementação**:
  - Criar interface `I...Service` e implementação `...Service`.
  - Registrar dependências no container de DI.
  - Utilizar `async/await` com `CancellationToken`.
- **Critério de Validação**:
  - `dotnet test` com todos os testes passando com sucesso.

---

### T5: Endpoints / Controllers e Documentação
- **Objetivo**: Expor os endpoints HTTP e integrar com a camada de serviço.
- **Implementação**:
  - Criar Controller ou Minimal API endpoints.
  - Mapear Request DTO -> Chamada do Serviço -> Response DTO.
  - Tratar status codes adequados (200, 201, 400, 404).
- **Critério de Validação**:
  - `dotnet build` com 0 erros; endpoints visíveis e validados.

