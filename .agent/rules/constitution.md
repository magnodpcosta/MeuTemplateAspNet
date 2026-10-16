# Constituição do Projeto (.NET / ASP.NET Core)

## Regras Imutáveis (Obrigatórias em todas as Tasks)

1. **Arquitetura e Dados**:
   - Utilizar Entity Framework Core com Code-First.
   - Nunca acessar o `DbContext` diretamente nos Endpoints/Controllers; utilizar sempre a camada de Serviços ou Repositórios.
   - Utilizar DTOs (Records) para Request e Response. Nunca expor Entidades de domínio diretamente na API.

2. **Assincronismo e Performance**:
   - Todo acesso a banco ou I/O deve ser assíncrono (`async/await`) e receber `CancellationToken`.
   - Utilizar `.AsNoTracking()` em consultas apenas de leitura no EF Core.

3. **Segurança e Configuração**:
   - Nunca expor Secrets, Connection Strings ou chaves JWT hardcoded no código.
   - Não modificar endpoints ou contratos existentes sem solicitação explícita na Task.

4. **Qualidade**:
   - A aplicação deve compilar com `dotnet build` com 0 erros ao final de cada tarefa.

